package com.ntumart.dipapp.api.service;

import org.springframework.util.StringUtils;
import com.ntumart.dipapp.api.DTO.ProductDTO;
import com.ntumart.dipapp.api.repository.ProductRepository;
import com.ntumart.dipapp.exceptions.EmptyFileException;
import com.ntumart.dipapp.exceptions.ProductNotFoundException;
import com.ntumart.dipapp.models.Product;
import java.nio.file.*;
import java.text.SimpleDateFormat;
import java.io.*;
import java.util.Arrays;
import java.util.Date;
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

    private String uploadDir = ".//src//main//resources//images//uploads";

    public void addProduct(Product product, ProductDTO productDTO, MultipartFile productPicture)
            throws IOException, EmptyFileException {
        try {
            if (!productPicture.isEmpty()) {
                byte[] fileBytes = productPicture.getBytes();
                String fileName = StringUtils.cleanPath(productPicture.getOriginalFilename());
                
                product.setProductPic(String.format("images/uploads/%s/", product.getSellerID()) + fileName);
                String dir = uploadDir + "//" + product.getSellerID();
                Files.createDirectories(Paths.get(dir));
                Path filePath = Paths.get(dir, fileName);
                OutputStream os = Files.newOutputStream(filePath);
                os.write(fileBytes);
                os.close();
                productRepository.save(product);
            } else {
                throw new EmptyFileException("The uploaded file is empty.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Product getProductById(int productID) throws ProductNotFoundException {
        Product product = productRepository.findById(productID)
                .orElse(null); // Assign null if not found
        if (product == null) {
            throw new ProductNotFoundException("Product not found");
        }
        return product;
    }

    public void updateProduct(int productID, ProductDTO productDTO, MultipartFile data)
            throws IOException, ProductNotFoundException { // Change Long to int
        Product product = getProductById(productID);
        byte[] fileBytes = data.getBytes();
        String fileName = StringUtils.cleanPath(data.getOriginalFilename());
        int sellerID = product.getSellerID();
        product.setName(productDTO.getName());
        product.setDescription(productDTO.getDescription());
        product.setPrice(productDTO.getPrice());
        product.setQuantity(productDTO.getQuantity());
        String dir = uploadDir + "//" + sellerID;
        Files.createDirectories(Paths.get(dir));
        Path filePath = Paths.get(dir, fileName);
        Files.createFile(filePath);
        OutputStream os = Files.newOutputStream(filePath);
        os.write(fileBytes);
        os.close();
        product.setProductPic(String.format("images/uploads/%s/", sellerID) + fileName);
        productRepository.save(product);
    }

    // public void updateProduct(int productID, MultipartFile data)
    //         throws IOException, ProductNotFoundException { // Change Long to int
    //     Product product = getProductById(productID);
    //     byte[] fileBytes = data.getBytes();
    //     String fileName = StringUtils.cleanPath(data.getOriginalFilename());
    //     int prodID = product.getProductID();
    //     product.setName(product.getName());
    //     product.setDescription(product.getDescription());
    //     product.setPrice(product.getPrice());
    //     product.setQuantity(product.getQuantity());
    //     String dir = uploadDir + "//" + prodID;
    //     Files.createDirectories(Paths.get(dir));
    //     Path filePath = Paths.get(dir, fileName);
    //     Files.createFile(filePath);
    //     OutputStream os = Files.newOutputStream(filePath);
    //     os.write(fileBytes);
    //     os.close();
    //     product.setProductPic(String.format("images/uploads/%s/", prodID) + fileName);
    //     productRepository.save(product);
    // }

    public void deleteProduct(int productID) throws IOException, ProductNotFoundException{
        //Check if the product exists
        Product product = getProductById(productID);
        productRepository.delete(product);
    }

    
}
