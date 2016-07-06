package com.sn.lobtool.domain;

public class PaymentMethods {
    
    private String payMethodId;
    
    private Integer numOfTrans;
    
    private String payMethodName;
    
    private Double proportion;

    public String getPayMethodId() {
        return payMethodId;
    }

    public void setPayMethodId(String payMethodId) {
        this.payMethodId = payMethodId;
    }

    public Integer getNumOfTrans() {
        return numOfTrans;
    }

    public void setNumOfTrans(Integer numOfTrans) {
        this.numOfTrans = numOfTrans;
    }

    public String getPayMethodName() {
        return payMethodName;
    }

    public void setPayMethodName(String payMethodName) {
        this.payMethodName = payMethodName;
    }

    public Double getProportion() {
        return proportion;
    }

    public void setProportion(Double proportion) {
        this.proportion = proportion;
    }
    
}
