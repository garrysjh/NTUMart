package com.ntumart.dipapp.models;

public class FileData {
  private String fileName;
  private String fileType;
  private byte[] content;

  public FileData(String fileName, String fileType, byte[] content) {
    this.fileName = fileName;
    this.fileType = fileType;
    this.content = content;
  }

  public String getFileName() {
    return fileName;
  }

  public void setFileName(String fileName) {
    this.fileName = fileName;
  }

  public String getFileType() {
    return fileType;
  }

  public void setFileType(String fileType) {
    this.fileType = fileType;
  }

  public byte[] getContent() {
    return content;
  }

  public void setContent(byte[] content) {
    this.content = content;
  }
}
