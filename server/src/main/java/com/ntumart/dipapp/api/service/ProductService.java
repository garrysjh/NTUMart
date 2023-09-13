package com.ntumart.dipapp.api.service;
import org.springframework.util.StringUtils;
import com.ntumart.dipapp.api.DTO.ProductDTO;
import com.ntumart.dipapp.api.repository.ProductRepository;
import com.ntumart.dipapp.models.Product;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service

public class ProductService {
    
    @Autowired
    ProductRepository productRepository;

    // public void addProduct(Product product){
    //     productRepository.save(product);
    // }

    @Value("${upload-dir}")
    private String uploadDir;

    public void addProduct(ProductDTO productDTO, MultipartFile data) throws IOException{
        
        // Product product = new Product();
        // product.setName(productDTO.getName());
        // product.setDescription(productDTO.getDescription());
        // product.setPrice(productDTO.getPrice());
        // product.setQuantity(productDTO.getQuantity());

        if(!data.isEmpty()) {
            byte[] fileBytes = data.getBytes();
            String fileName = StringUtils.cleanPath(data.getOriginalFilename());

            Product product = new Product();
            product.setName(productDTO.getName());
            product.setDescription(productDTO.getDescription());
            product.setPrice(productDTO.getPrice());
            product.setQuantity(productDTO.getQuantity());
            product.setProductPic(fileName);
            product.setData(fileBytes);

            productRepository.save(product);
            String filePath = Paths.get(uploadDir, fileName).toString();
            data.transferTo(new File(filePath));

        }

        // try {
        //     product.setData(data.getBytes());
        //     // product.setData(data.getBytes())
        // } catch (IOException e) {
        //     // return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error");
        // }

        // productRepository.save(product);
    }

    public Product getProductById(int id) {
        Product product = productRepository.findById(id)
            .orElse(null); // Assign null if not found
        if (product == null) {
            // throw new ProductNotFoundException("Product not found");
        }
        return product;
    }

    public void updateProduct(int productID, Product updatedProduct, MultipartFile data) throws IOException { // Change Long to int
        Product product = getProductById(productID);

        byte[] fileBytes = data.getBytes();
        String fileName = StringUtils.cleanPath(data.getOriginalFilename());

        // Update product attributes based on the updatedProduct object
        product.setName(updatedProduct.getName());
        product.setDescription(updatedProduct.getDescription());
        product.setPrice(updatedProduct.getPrice());
        product.setQuantity(updatedProduct.getQuantity());
        product.setProductPic(fileName);
        product.setData(fileBytes);

        productRepository.save(product);
    }

    

    

    // public int checkQuantity(int quantity){return productRepository.checkExistingQuantity(quantity); }

}
