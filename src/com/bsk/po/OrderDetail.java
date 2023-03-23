package com.bsk.po;

public class OrderDetail {
    private Integer orderDetailsId;
    private String productName;
    private Integer productNum;
    private Double productMoney;
    private Integer orderId;

    public OrderDetail() {
    }

    public Integer getOrderDetailsId() {
        return orderDetailsId;
    }

    public void setOrderDetailsId(Integer orderDetailsId) {
        this.orderDetailsId = orderDetailsId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getProductNum() {
        return productNum;
    }

    public void setProductNum(Integer productNum) {
        this.productNum = productNum;
    }

    public Double getProductMoney() {
        return productMoney;
    }

    public void setProductMoney(Double productMoney) {
        this.productMoney = productMoney;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "orderDetailsId=" + orderDetailsId +
                ", productName='" + productName + '\'' +
                ", productNum=" + productNum +
                ", productMoney=" + productMoney +
                ", orderId=" + orderId +
                '}';
    }
}
