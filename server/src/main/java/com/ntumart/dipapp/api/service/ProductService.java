package com.ntumart.dipapp.api.service;

import org.springframework.util.StringUtils;
import com.ntumart.dipapp.api.DTO.ProductDTO;
import com.ntumart.dipapp.api.repository.ProductRepository;
import com.ntumart.dipapp.exceptions.EmptyFileException;
import com.ntumart.dipapp.exceptions.ProductNotFoundException;
import com.ntumart.dipapp.models.Product;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.io.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service

public class ProductService {

    @Autowired
    ProductRepository productRepository;

    private String uploadDir = ".//src//main//resources//images//uploads";

    public void addProduct(Product product, ProductDTO productDTO, MultipartFile productPicture, MultipartFile productPicture2, MultipartFile productPicture3, MultipartFile productPicture4)
            throws IOException, EmptyFileException {
        try {
            if (!productPicture.isEmpty() && !productPicture2.isEmpty() && !productPicture3.isEmpty() && !productPicture4.isEmpty()) {
                byte[] fileBytes = productPicture.getBytes();
                String fileName = StringUtils.cleanPath(productPicture.getOriginalFilename());
                product.setDate(LocalDateTime.now());
                product.setProductPic(String.format("images/uploads/%s/", product.getSellerID()) + fileName);
                String dir = uploadDir + "//" + product.getSellerID();
                Files.createDirectories(Paths.get(dir));
                Path filePath = Paths.get(dir, fileName);
                OutputStream os = Files.newOutputStream(filePath);
                os.write(fileBytes);
                os.close();

                byte[] fileBytes2 = productPicture2.getBytes();
                String fileName2 = StringUtils.cleanPath(productPicture2.getOriginalFilename());
                
                product.setProductPic2(String.format("images/uploads/%s/", product.getSellerID()) + fileName2);
                String dir2 = uploadDir + "//" + product.getSellerID();
                Files.createDirectories(Paths.get(dir2));
                Path filePath2 = Paths.get(dir2, fileName2);
                OutputStream os2 = Files.newOutputStream(filePath2);
                os2.write(fileBytes2);
                os2.close();

                byte[] fileBytes3 = productPicture3.getBytes();
                String fileName3 = StringUtils.cleanPath(productPicture3.getOriginalFilename());
                
                product.setProductPic3(String.format("images/uploads/%s/", product.getSellerID()) + fileName3);
                String dir3 = uploadDir + "//" + product.getSellerID();
                Files.createDirectories(Paths.get(dir3));
                Path filePath3 = Paths.get(dir3, fileName3);
                OutputStream os3 = Files.newOutputStream(filePath3);
                os3.write(fileBytes3);
                os3.close();

                byte[] fileBytes4 = productPicture4.getBytes();
                String fileName4 = StringUtils.cleanPath(productPicture4.getOriginalFilename());
                
                product.setProductPic4(String.format("images/uploads/%s/", product.getSellerID()) + fileName4);
                String dir4 = uploadDir + "//" + product.getSellerID();
                Files.createDirectories(Paths.get(dir4));
                Path filePath4 = Paths.get(dir4, fileName4);
                OutputStream os4 = Files.newOutputStream(filePath4);
                os4.write(fileBytes4);
                os4.close();
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

    public void updateProduct(int productID, ProductDTO productDTO, MultipartFile productPicture, MultipartFile productPicture2, MultipartFile productPicture3, MultipartFile productPicture4)
            throws IOException, ProductNotFoundException { // Change Long to int
        Product product = getProductById(productID);
        byte[] fileBytes = productPicture.getBytes();
        String fileName = StringUtils.cleanPath(productPicture.getOriginalFilename());
        //int sellerID = product.getSellerID();
        product.setName(productDTO.getName());
        product.setDescription(productDTO.getDescription());
        product.setPrice(productDTO.getPrice());
        product.setQuantity(productDTO.getQuantity());
        String dir = uploadDir + "//" + product.getSellerID();;
        Files.createDirectories(Paths.get(dir));
        Path filePath = Paths.get(dir, fileName);
        Files.createFile(filePath);
        OutputStream os = Files.newOutputStream(filePath);
        os.write(fileBytes);
        os.close();
        product.setProductPic(String.format("images/uploads/%s/", product.getSellerID()) + fileName);

        // FOR 2ND PRODUCT PICTURE
        byte[] fileBytes2 = productPicture2.getBytes();
        String fileName2 = StringUtils.cleanPath(productPicture2.getOriginalFilename());
        String dir2 = uploadDir + "//" + product.getSellerID();;
        Files.createDirectories(Paths.get(dir2));
        Path filePath2 = Paths.get(dir2, fileName2);
        Files.createFile(filePath2);
        OutputStream os2 = Files.newOutputStream(filePath2);
        os2.write(fileBytes2);
        os2.close();
        product.setProductPic2(String.format("images/uploads/%s/", product.getSellerID()) + fileName2);

        // FOR 3RD PRODUCT PICTURE
        byte[] fileBytes3 = productPicture3.getBytes();
        String fileName3 = StringUtils.cleanPath(productPicture3.getOriginalFilename());
        String dir3 = uploadDir + "//" + product.getSellerID();;
        Files.createDirectories(Paths.get(dir3));
        Path filePath3 = Paths.get(dir3, fileName3);
        Files.createFile(filePath3);
        OutputStream os3 = Files.newOutputStream(filePath3);
        os3.write(fileBytes3);
        os3.close();
        product.setProductPic3(String.format("images/uploads/%s/", product.getSellerID()) + fileName3);

        // FOR 4TH PRODUCT PICTURE
        byte[] fileBytes4 = productPicture4.getBytes();
        String fileName4 = StringUtils.cleanPath(productPicture4.getOriginalFilename());
        String dir4 = uploadDir + "//" + product.getSellerID();;
        Files.createDirectories(Paths.get(dir4));
        Path filePath4 = Paths.get(dir4, fileName4);
        Files.createFile(filePath4);
        OutputStream os4 = Files.newOutputStream(filePath4);
        os4.write(fileBytes4);
        os4.close();
        product.setProductPic4(String.format("images/uploads/%s/", product.getSellerID()) + fileName4);
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
