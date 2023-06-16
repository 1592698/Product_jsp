package market.ver01.dao;

import market.ver01.dto.Product;

import java.util.ArrayList;
public class ProductRepository {

    private ArrayList<Product> listOfProducts = new ArrayList<Product>();

    private static ProductRepository instance = new ProductRepository(); // 추가 코드

    public static ProductRepository getInstance() { //추가 코드
        return instance;
    }

    public ProductRepository() {
        Product phone = new Product("P1234", "iphone 6s", 80000);
        phone.setDescription("4.7인치, 1334x750 레티나 HD 디스플레이, 8메가픽셀 insight 카메라");
        phone.setCategory("Smart Phone");
        phone.setManufacturer("Apple");
        phone.setUnitsInStock(1000);
        phone.setCondition("New");
        phone.setFilename("P1234.png");

        Product notebook = new Product("p1235", "LG PC 그램", 150000);
        notebook.setDescription("13.3인치, IPS LED 디스플레이, 5rd 제너레이션 인텔 코어 프로세서");
        notebook.setCategory("Notebook");
        notebook.setManufacturer("LG");
        notebook.setUnitsInStock(1000);
        notebook.setCondition("Refurbished");
        notebook.setFilename("P1235.png");

        Product tablet = new Product("p1236", "갤럭시 탭 S", 90000);
        tablet.setDescription("212.8*125.6*6.6mm, 슈퍼 아몰레드 디스플레이, octa-core processor");
        tablet.setCategory("Tablet");
        tablet.setManufacturer("삼성");
        tablet.setUnitsInStock(1000);
        tablet.setCondition("old");
        tablet.setFilename("P1236.png");

        listOfProducts.add(phone);
        listOfProducts.add(notebook);
        listOfProducts.add(tablet);
    }
    public ArrayList<Product> getAllProducts(){
        return listOfProducts;
    }

    //제품목록에서 상세페이지 펼칠 때 어떤 제품인지 알기 위해서 해당되는 제품을 찾는거.(아이디로)
    public Product getProductById(String productId) {
        Product productById=null;

        for(int i=0; i<listOfProducts.size(); i++) {
            Product product = listOfProducts.get(i);
            if(product != null && product.getProductId() != null && product.getProductId().equals(productId)) {
                productById=product;
                break;
            }
        }
        return productById;
    }

    public void addProduct(Product product) { //추가 코드
        listOfProducts.add(product);
    }
}
