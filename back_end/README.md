# GETGOODS Backend API

## Base URL
The base URL for the API is: 127.0.0.1:8000/api/v1/

## Authentication

## Models
### Product Model
| Field       | Type   | Description                                                                                                 |
|-------------|--------|-------------------------------------------------------------------------------------------------------------|
| shop_id     | String | A unique identifier for the shop that sells the product.                                                     |
| discount    | Number | The discount amount (in percentage) applied to the product. Defaults to 0 if no discount is available.     |
| name        | String | The name of the product. (Max length 40)                                                                    |
| slug        | String | Used for generating product URLs.                                                                           |
| price       | Number | The price of the product.                                                                                   |
| description | String | Description of the product.                                                                                 |
| category    | Array  | The category to which the product belongs. Can be one of the following: *processed, otop, medicinalPlant, driedGood*. |
| quantity    | Number | The quantity of the product available in stock.                                                             |
| sold        | Number | The number of units sold for the product.                                                                   |
| image       | Array  | Product image.                                                                                              |
| rating      | Number | A rating value ranging from 0 to 5, representing the average rating of the product.                         |

## Endpoints
### Get All Products
- URL: /products
- Method: GET
- Description: 
- Request Parameters: None
- Response Format:
    - status: The status of the response ('success' or 'fail').
    - results: The total number of products returned.
    - data.products: An array of product objects containing their details.
- Example Response:
```
{
    "status": "success",
    "results": 27,
    "data": {
        "products": [
            {
                "_id": "647a25b17b88d233f006572b",
                "shop_id": "shop_id_1",
                "discount": 10,
                "name": "Handmade Woven Bag",
                "slug": "handmade-woven-bag",
                "price": 250,
                "description": "This beautiful handmade woven bag is crafted by skilled artisans in a small village in Northern Thailand.",
                "category": "otop",
                "quantity": 50,
                "sold": 0,
                "images": [],
                "ratings": 0,
                "createdAt": "2023-06-02T17:24:01.310Z",
                "updatedAt": "2023-06-02T17:24:01.310Z",
                "__v": 0
            },
            {
                "_id": "647a25d47b88d233f006572d",
                "shop_id": "shop_id_1",
                "discount": 0,
                "name": "Thai Green Curry Paste",
                "slug": "thai-green-curry-paste",
                "price": 80,
                "description": "Authentic Thai green curry paste made from fresh ingredients, perfect for creating delicious and flavorful curries.",
                "category": "processed",
                "quantity": 100,
                "sold": 0,
                "images": [],
                "ratings": 0,
                "createdAt": "2023-06-02T17:24:36.599Z",
                "updatedAt": "2023-06-02T17:24:36.599Z",
                "__v": 0
            },
            {
                "_id": "647a25e37b88d233f006572f",
                "shop_id": "shop_id_2",
                "discount": 15,
                "name": "Aloe Vera Gel",
                "slug": "aloe-vera-gel",
                "price": 150,
                "description": "Pure and natural aloe vera gel extracted from locally grown medicinal plants. Soothes and moisturizes the skin.",
                "category": "medicinalPlant",
                "quantity": 30,
                "sold": 0,
                "images": [],
                "ratings": 0,
                "createdAt": "2023-06-02T17:24:51.496Z",
                "updatedAt": "2023-06-02T17:24:51.496Z",
                "__v": 0
            },
            {
                "_id": "647a25fc7b88d233f0065731",
                "shop_id": "shop_id_3",
                "discount": 0,
                "name": "Dried Mango Slices",
                "slug": "dried-mango-slices",
                "price": 120,
                "description": "Delicious and healthy dried mango slices made from ripe mangoes grown in the tropical orchards of Thailand.",
                "category": "driedGood",
                "quantity": 80,
                "sold": 0,
                "images": [],
                "ratings": 0,
                "createdAt": "2023-06-02T17:25:16.179Z",
                "updatedAt": "2023-06-02T17:25:16.179Z",
                "__v": 0
            },
            {
                "_id": "647a260f7b88d233f0065733",
                "shop_id": "shop_id_1",
                "discount": 0,
                "name": "Thai Green Curry Paste",
                "slug": "thai-green-curry-paste",
                "price": 80,
                "description": "Authentic Thai green curry paste made from fresh ingredients, perfect for creating delicious and flavorful curries.",
                "category": "processed",
                "quantity": 100,
                "sold": 0,
                "images": [],
                "ratings": 0,
                "createdAt": "2023-06-02T17:25:35.061Z",
                "updatedAt": "2023-06-02T17:25:35.061Z",
                "__v": 0
            },
            {
                "_id": "647a26197b88d233f0065735",
                "shop_id": "shop_id_2",
                "discount": 15,
                "name": "Aloe Vera Gel",
                "slug": "aloe-vera-gel",
                "price": 150,
                "description": "Pure and natural aloe vera gel extracted from locally grown medicinal plants. Soothes and moisturizes the skin.",
                "category": "medicinalPlant",
                "quantity": 30,
                "sold": 0,
                "images": [],
                "ratings": 0,
                "createdAt": "2023-06-02T17:25:45.636Z",
                "updatedAt": "2023-06-02T17:25:45.636Z",
                "__v": 0
            },
        ...
        ]
    }
}
```

### Filter Products
- URL: /products?`filter parameters`
= Method: GET
= Description: Filters products based on specified query parameters.
- Request Parameters:
    - price[gt]: Filters products with a price higher than the specified value.
        - gte: greater than or equal
        - gt: greater than
        - lte: less than or equal
        - lt: less than
    - category: Filters products by their category.
- Response Format:
    - status: The status of the response ('success' or 'fail').
    - results: The total number of products returned.
    - data.products: An array of product objects containing their details.
- Example Request:
```
products?price[gt]=150&category=medicinalPlant
```
- Example Response:
```
{
    "status": "success",
    "results": 2,
    "data": {
        "products": [
            {
                "_id": "647a264f7b88d233f0065743",
                "shop_id": "shop_id_2",
                "discount": 0,
                "name": "Herbal Massage Oil",
                "slug": "herbal-massage-oil",
                "price": 200,
                "description": "Relax and rejuvenate with this herbal massage oil infused with traditional Thai herbs, perfect for a soothing massage.",
                "category": "medicinalPlant",
                "quantity": 40,
                "sold": 0,
                "images": [],
                "ratings": 0,
                "createdAt": "2023-06-02T17:26:39.964Z",
                "updatedAt": "2023-06-02T17:26:39.964Z",
                "__v": 0
            },
            {
                "_id": "647a266c7b88d233f006574b",
                "shop_id": "shop_id_2",
                "discount": 5,
                "name": "Herbal Shampoo",
                "slug": "herbal-shampoo",
                "price": 180,
                "description": "Gentle and nourishing herbal shampoo infused with natural Thai herbs, promoting healthy and shiny hair.",
                "category": "medicinalPlant",
                "quantity": 60,
                "sold": 0,
                "images": [],
                "ratings": 0,
                "createdAt": "2023-06-02T17:27:08.632Z",
                "updatedAt": "2023-06-02T17:27:08.632Z",
                "__v": 0
            }
        ]
    }
}
```

### Create Product
- URL: /products
- Method: POST
- Description: Creates a new product.
- Request Body: follow the product model.
- Response Format:
    - status: The status of the response ('success' or 'fail').
    - data.product: The created product object containing its details.
- Example Request:
```
  {
    "shop_id": "shop_id_1",
    "discount": 10,
    "name": "Thai chill cashews",
    "slug": "thai-chili-cashews",
    "price": 100,
    "description": "Crunchy cashews coated with a savory blend of Thai spices and chili, perfect for snacking or adding to dishes.",
    "category": "processed",
    "quantity": 90
  }
```
- Example Response:
```
{
    "status": "success",
    "data": {
        "product": {
            "shop_id": "shop_id_1",
            "discount": 10,
            "name": "Thai chill cashews",
            "slug": "thai-chili-cashews",
            "price": 100,
            "description": "Crunchy cashews coated with a savory blend of Thai spices and chili, perfect for snacking or adding to dishes.",
            "category": "processed",
            "quantity": 90,
            "sold": 0,
            "images": [],
            "ratings": 0,
            "_id": "647a2f82b5bfa2f051b334cb",
            "createdAt": "2023-06-02T18:05:54.875Z",
            "updatedAt": "2023-06-02T18:05:54.875Z",
            "__v": 0
        }
    }
}
```

### Update Product
- URL: /products/:id
- Method: PATCH
- Description: Updates an existing product by its ID.
- Request Parameters:
    - id: The unique identifier of the product to be updated.
- Request Body: The fields to be updated in the product object.
- Response Format:
    - status: The status of the response ('success' or 'fail').
    - data.product: The updated product object containing its details.
- Example Request:
```
/products/product_id
```
```
{
  "price": 100,
}
```
- Example Response:
```
{
    "status": "success",
    "data": {
        "product": {
            "_id": "647a2f82b5bfa2f051b334cb",
            "shop_id": "shop_id_1",
            "discount": 10,
            "name": "Thai chill cashews",
            "slug": "thai-chili-cashews",
            "price": 100,
            "description": "Crunchy cashews coated with a savory blend of Thai spices and chili, perfect for snacking or adding to dishes.",
            "category": "processed",
            "quantity": 90,
            "sold": 0,
            "images": [],
            "ratings": 0,
            "createdAt": "2023-06-02T18:05:54.875Z",
            "updatedAt": "2023-06-02T18:10:47.383Z",
            "__v": 0
        }
    }
}
```

#### Delete Product
- URL: /products/:id
-  Method: DELETE
- Description: Deletes a product by its ID.
- Request Parameters:
    - id: The unique identifier of the product to be deleted.
- Response Format:
    - status: The status of the response ('success' or 'fail').
    - message: A message indicating the result of the deletion operation.
Example Response:
    - status code: 204 No content

