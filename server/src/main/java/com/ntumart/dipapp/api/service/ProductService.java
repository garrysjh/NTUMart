package com.ntumart.dipapp.api.service;

import org.springframework.util.StringUtils;
import com.ntumart.dipapp.api.DTO.ProductDTO;
import com.ntumart.dipapp.api.repository.ProductRepository;
import com.ntumart.dipapp.exceptions.EmptyFileException;
import com.ntumart.dipapp.exceptions.ProductNotFoundException;
import com.ntumart.dipapp.models.Product;
import java.nio.file.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.io.*;
import java.util.*;

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

    public void addProduct(Product product, ProductDTO productDTO, MultipartFile productPicture, MultipartFile productPicture2,
                           MultipartFile productPicture3, MultipartFile productPicture4) throws IOException, EmptyFileException {
        try {
            if (!isEmpty(productPicture)) {
                saveProductPicture(product, productPicture);
            }
            if (!isEmpty(productPicture2)) {
                saveProductPicture(product, productPicture2);
            }
            if (!isEmpty(productPicture3)) {
                saveProductPicture(product, productPicture3);
            }
            if (!isEmpty(productPicture4)) {
                saveProductPicture(product, productPicture4);
            }

            productRepository.save(product);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void saveProductPicture(Product product, MultipartFile file) throws IOException, EmptyFileException {
        if (isEmpty(file)) {
            throw new EmptyFileException("The uploaded file is empty.");
        }

        byte[] fileBytes = file.getBytes();
        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        product.setDate(LocalDateTime.now());
        fileName = product.getSellerID() + "_pp.jpg";
        String dir = uploadDir + "//" + product.getSellerID();
        Files.createDirectories(Paths.get(dir));
        String productPicField = getNextAvailableProductPicField(product);

        product.setProductPic(String.format("images/uploads/%s/", product.getSellerID()) + fileName);
        Path filePath = Paths.get(dir, fileName);
        try (OutputStream os = Files.newOutputStream(filePath)) {
            os.write(fileBytes);
        }
    }

    private boolean isEmpty(MultipartFile file) {
        return file == null || file.isEmpty();
    }

    private String getNextAvailableProductPicField(Product product) {
        if (StringUtils.isEmpty(product.getProductPic())) {
            return "productPic";
        } else if (StringUtils.isEmpty(product.getProductPic2())) {
            return "productPic2";
        } else if (StringUtils.isEmpty(product.getProductPic3())) {
            return "productPic3";
        } else if (StringUtils.isEmpty(product.getProductPic4())) {
            return "productPic4";
        } else {
            // Handle the case where all fields are already populated
            return null;
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

    public Product incrementProductLikes(int productID) throws ProductNotFoundException {
        Product product = productRepository.findById(productID)
                .orElse(null);
        product.setProductLikes(product.getProductLikes() + 1);

        return productRepository.save(product);
    }

    public Product decrementProductLikes(int productID) throws ProductNotFoundException {
        Product product = productRepository.findById(productID)
                .orElse(null);
        product.setProductLikes(product.getProductLikes() - 1);

        return productRepository.save(product);
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
        product.setCategory(productDTO.getCategory());
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

//    public List<Product> findCategory(String category)  {
//        return productRepository.findCategory(category);
//    }

    public List<Product> findCategory(List<String> category)  {
        List<Product> matching = new ArrayList<>();
        for (String categories : category) {
            List<Product> products = productRepository.findCategory(categories);
            matching.addAll(products);
        }
        return matching;
    }

    
}
