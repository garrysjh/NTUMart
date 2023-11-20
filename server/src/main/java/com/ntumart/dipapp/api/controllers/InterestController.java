package com.ntumart.dipapp.api.controllers;

import com.ntumart.dipapp.api.repository.InterestRepository;
import com.ntumart.dipapp.api.service.InterestService;
import com.ntumart.dipapp.exceptions.EmptyFileException;
import com.ntumart.dipapp.exceptions.ProductNotFoundException;
import com.ntumart.dipapp.models.Interest;
import java.io.IOException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/user")
public class InterestController {

  @Autowired InterestService interestService;
  @Autowired InterestRepository interestRepository;

  @RequestMapping(
      value = "/addinterest",
      method = RequestMethod.POST,
      produces = {"application/json"})
  @ResponseBody
  public ResponseEntity<String> addInterest(@RequestBody Interest interest) {
    try {
      interestService.addInterest(interest);
      System.out.println("Received Interest object: " + interest);
      return ResponseEntity.ok("Interest Added Successfully");
    } catch (EmptyFileException e) {
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("File is empty");
    } catch (IOException e) {
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
          .body("Error uploading the file");
    }
  }

  @GetMapping("/interest/{userID}")
  public ResponseEntity<List<Object>> userID(@PathVariable int userID)
      throws ProductNotFoundException {
    List<Object> interest = interestRepository.userID(userID);

    if (interest == null) {
      return ResponseEntity.notFound().build();
    }

    return ResponseEntity.ok(interest);
  }

  @GetMapping("/{userID}/checkInterest")
  public ResponseEntity<String> checkCategory(@PathVariable int userID) {
    Interest interest = interestRepository.checkCategory(userID);

    if (interest == null) {
      return ResponseEntity.notFound().build();
    }

    if (interest.getCategory1() == null || interest.getCategory1().isEmpty()) {
      return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Categories is empty");
    } else {
      // } else if(interest.getCategory2() == null || interest.getCategory2().isEmpty()){
      //     return ResponseEntity.ok("4 Categories is not selected");
      // } else if(interest.getCategory3() == null || interest.getCategory3().isEmpty()){
      //     return ResponseEntity.ok("3 Categories is not selected");
      // } else if(interest.getCategory4() == null || interest.getCategory4().isEmpty()){
      //     return ResponseEntity.ok("2 Categories is not selected");
      // } else if(interest.getCategory5() == null || interest.getCategory5().isEmpty()){
      //     return ResponseEntity.ok("1 Categories is not selected");
      // } else {
      return ResponseEntity.status(HttpStatus.FOUND).body("No issue");
    }
  }

  @GetMapping("/checking/{userID}")
  public ResponseEntity<Interest> getInterestByUserID(@PathVariable int userID)
      throws ProductNotFoundException {
    Interest interest = interestService.getInterestByUserID(userID);
    return ResponseEntity.ok(interest);
  }

  @PostMapping("/updateInterest/{userID}")
  public ResponseEntity<String> updateInterest(
      @PathVariable int userID,
      @RequestParam(value = "category1") String category1,
      @RequestParam(value = "category2") String category2,
      @RequestParam(value = "category3") String category3,
      @RequestParam(value = "category4") String category4,
      @RequestParam(value = "category5") String category5)
      throws IOException, ProductNotFoundException {
    interestService.updateInterest(userID, category1, category2, category3, category4, category5);
    return ResponseEntity.ok("Interest Updated Successfully");
  }
}
