from django.db.models import Q
from django.http import Http404
from django.shortcuts import get_object_or_404

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.decorators import api_view

from .models import Product, Category
from .serializers import ProductSerializer,CategorySerializer

class LatestProductsList(APIView):
    def get(self, request, format=None):
        products = Product.objects.all()[0:4]
        serializer = ProductSerializer(products, many=True)
        return Response(serializer.data)
    
class ProductDetail(APIView):
    def get_object(self, category_slug, product_slug):
        category = get_object_or_404(Category, slug=category_slug)
        return get_object_or_404(Product, category=category, slug=product_slug)

        
    def get(self, request, category_slug, product_slug, format=None):
        product = self.get_object(category_slug, product_slug)
        serializer = ProductSerializer(product)
        return Response(serializer.data)
    
class CategoryDetail(APIView):
    def get_object(self, category_slug):
        return get_object_or_404(Category, slug=category_slug)

    def get(self, request, category_slug, format=None):
        category = self.get_object(category_slug)
        serializer = CategorySerializer(category)
        return Response(serializer.data)
    
@api_view(['POST'])
def search(request):
    query = request.data.get('query','')
    if query:
        products = Product.objects.filter(Q(name__icontains = query)| Q (description__icontains = query))
        serializer = ProductSerializer(products, many = True)
        return Response(serializer.data)
    else:
        return Response({"products": []})
        