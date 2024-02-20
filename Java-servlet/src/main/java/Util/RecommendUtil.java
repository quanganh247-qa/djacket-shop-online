package Util;
import java.util.*;
import Data.InvoiceDB;
import business.Invoice;
import business.Product;

public class RecommendUtil {
    private Map<String,double[]> productsVector;
    List<Invoice> invoices = InvoiceDB.selectInvoice();

    private static Map<String, Double> createOriginToNumberMap(List<Product> products) {
        Map<String, Double> originToNumberMap = new HashMap<>();
        double value = 1.0;

        for (Product product : products) {
            String origin = product.getOrigin();
            if (!originToNumberMap.containsKey(origin)) {
                originToNumberMap.put(origin, value);
                value += 1.0;
            }
        }

        return originToNumberMap;
    }
    private static double getOriginValue(Object originValue, Map<String, Double> originToNumberMap) {
        if (originValue instanceof Integer) {
            return (double) (int) originValue;
        } else if (originValue instanceof Double) {
            return (double) originValue;
        } else if (originValue instanceof String) {
            // Use the originToNumberMap for consistent conversion
            return originToNumberMap.getOrDefault((String) originValue, 0.0);
        } else {
            return 0.0;
        }
    }


    public static Map<String, double[]> ProductVectors(List<Product> products) {
        Map<String, Map<String, Object>> productVectors = new HashMap<>();

        // Create a map to convert origin to a numeric value
        Map<String, Double> originToNumberMap = createOriginToNumberMap(products);

        for (Product product : products) {
            String productName = product.getName();
            if (!productVectors.containsKey(productName)) {
                Map<String, Object> productAttributes = new HashMap<>();
//                productAttributes.put("quantity", product.getQuantity()); // Include quantity
                productAttributes.put("price", product.getPrice());
                productAttributes.put("origin", product.getOrigin());
                productVectors.put(productName, productAttributes);
            }
        }

        Map<String, double[]> result = new HashMap<>();
        for (Map.Entry<String, Map<String, Object>> entry : productVectors.entrySet()) {
            String productName = entry.getKey();
            Map<String, Object> attributes = entry.getValue();
//            double quantity = ((Number) attributes.get("quantity")).doubleValue(); // Include quantity
            double price = ((Number) attributes.get("price")).doubleValue();
            double origin = getOriginValue(attributes.get("origin"), originToNumberMap);

            double[] vector = {price, origin };
            result.put(productName, vector);
        }
        return result;
    }

    private static double cosineSimilarity(double[] vector1, double[] vector2) {
        double dotProduct = 0.0;
        double norm1 = 0.0;
        double norm2 = 0.0;

        for (int i = 0; i < vector1.length; i++) {
            dotProduct += vector1[i] * vector2[i];
            norm1 += Math.pow(vector1[i], 2);
            norm2 += Math.pow(vector2[i], 2);
        }

        if (norm1 == 0 || norm2 == 0) {
            return 0.0; // To handle division by zero
        }

        return dotProduct / (Math.sqrt(norm1) * Math.sqrt(norm2));
    }
    // Function to recommend products based on products the customer purchased
    public static List<Product> recommendProducts(List<Product> customerPurchasedProducts, List<Product> allProducts) {
        // Get the product vectors for all products
        Map<String, double[]> vectors1 = ProductVectors(allProducts);
        Map<String, double[]> vectors2 = ProductVectors(customerPurchasedProducts);
        List<Product> recommendedProducts = new ArrayList<>();
        List<ProductSimilarity> productSimilarities = new ArrayList<>();

        for (Map.Entry<String, double[]> entry1 : vectors1.entrySet()) {
            String productName1 = entry1.getKey();
            double[] vector1 = entry1.getValue();

            for (Map.Entry<String, double[]> entry2 : vectors2.entrySet()) {
                String productName2 = entry2.getKey();
                double[] vector2 = entry2.getValue();

                double similarity = cosineSimilarity(vector1, vector2);
                productSimilarities.add(new ProductSimilarity(productName1, productName2, similarity));

//                if (similarity > 0.7) {
//                    // Find the Product object in allProducts list and add it to recommendedProducts
//                    Product recommendedProduct = findProductByName(allProducts, productName1);
//                    if (recommendedProduct != null) {
//                        recommendedProducts.add(recommendedProduct);
//                    }
//                }
            }
        }
        productSimilarities.sort(Comparator.comparingDouble(ProductSimilarity::getSimilarity).reversed());

        // Select the top 3 products with the highest similarity
        Set<String> selectedProducts = new HashSet<>();
        for (ProductSimilarity productSimilarity : productSimilarities) {
            if (selectedProducts.size() >= 3) {
                break;
            }

            String recommendedProductName = productSimilarity.getProductName1();
            if (!selectedProducts.contains(recommendedProductName)) {
                Product recommendedProduct = findProductByName(allProducts, recommendedProductName);
                if (recommendedProduct != null) {
                    recommendedProducts.add(recommendedProduct);
                    selectedProducts.add(recommendedProductName);
                }
            }
        }

        return recommendedProducts;
    }

    // Helper function to find a Product by name in a list
    private static class ProductSimilarity {
        private final String productName1;
        private final String productName2;
        private final double similarity;

        public ProductSimilarity(String productName1, String productName2, double similarity) {
            this.productName1 = productName1;
            this.productName2 = productName2;
            this.similarity = similarity;
        }

        public String getProductName1() {
            return productName1;
        }

        public String getProductName2() {
            return productName2;
        }

        public double getSimilarity() {
            return similarity;
        }
    }
    private static Product findProductByName(List<Product> products, String productName) {
        for (Product product : products) {
            if (product.getName().equals(productName)) {
                return product;
            }
        }
        return null; // Product not found
    }
}

