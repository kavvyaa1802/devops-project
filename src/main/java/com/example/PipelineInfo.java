package com.example;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class PipelineInfo {

    private static final String VERSION = "1.0.0";
    private static final String STACK = "Jenkins + Maven + SonarQube + Tomcat + AWS EC2";
    private static final String AUTHOR = "Kavya Sri Nallani";
    private static final String PROJECT = "DevOps CI/CD Pipeline Demo";

    public String getVersion() { return VERSION; }
    public String getStack() { return STACK; }
    public String getAuthor() { return AUTHOR; }
    public String getProject() { return PROJECT; }

    public String getCurrentTime() {
        return LocalDateTime.now()
            .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public boolean isVersionValid(String version) {
        return version != null && version.matches("\\d+\\.\\d+\\.\\d+");
    }

    public String formatDeploymentInfo(String host, String container) {
        if (host == null || container == null) {
            return "Unknown deployment";
        }
        return String.format("Deployed on %s using %s", host, container);
    }
}
