<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Properties, java.io.InputStream" %>
<%
    Properties buildProps = new Properties();
    try {
        InputStream is = application.getResourceAsStream("/build.properties");
        if (is != null) buildProps.load(is);
    } catch (Exception e) { /* ignore */ }
    String buildNumber = buildProps.getProperty("build.number", "dev");
    String appVersion = buildProps.getProperty("app.version", "1.0.0");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>About — DevOps Pipeline Demo</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
        crossorigin="anonymous">
  <style>
    body { background: #0f172a; color: #e2e8f0; font-family: 'Segoe UI', sans-serif; }
    .card-dark { background: #1e293b; border: 1px solid #334155; border-radius: 12px; }
    .section-title { color: #60a5fa; font-weight: 700; margin-bottom: 16px; }
    table { color: #e2e8f0 !important; }
    td, th { border-color: #334155 !important; padding: 12px !important; }
    th { color: #94a3b8 !important; background: #0f172a !important; }
    footer { background: #020617; padding: 20px 0; color: #64748b; font-size: 0.85rem; }
  </style>
</head>
<body class="p-4">
<div class="container" style="max-width:900px">

  <!-- Back button -->
  <div class="mb-4">
    <a href="." class="btn btn-outline-light btn-sm">← Back to Home</a>
  </div>

  <!-- Header -->
  <div class="text-center mb-5">
    <h1 class="display-5 fw-bold text-white">About This Project</h1>
    <p style="color:#60a5fa;font-size:1.1rem;">Final Year DevOps Project · Kavya Sri Nallani</p>
    <span class="badge bg-success">v<%= appVersion %></span>
    <span class="badge bg-primary ms-2">Build #<%= buildNumber %></span>
  </div>

  <!-- Project Overview -->
  <div class="card-dark p-4 mb-4">
    <h4 class="section-title">📋 Project Overview</h4>
    <p style="color:#cbd5e1;line-height:1.8;">
      This project demonstrates a complete <strong style="color:#f1f5f9">CI/CD (Continuous Integration &
      Continuous Deployment)</strong> pipeline built on AWS EC2. Every code change pushed to GitHub
      automatically triggers a Jenkins pipeline that builds the application, runs unit tests,
      performs code quality analysis via SonarQube, and deploys the WAR file to Apache Tomcat —
      all without any manual intervention.
    </p>
  </div>

  <!-- Tech Stack -->
  <div class="card-dark p-4 mb-4">
    <h4 class="section-title">🛠️ Technology Stack</h4>
    <table class="table table-dark table-bordered">
      <thead>
        <tr>
          <th>Tool</th><th>Version</th><th>Purpose</th>
        </tr>
      </thead>
      <tbody>
        <tr><td>AWS EC2</td><td>t2.medium · Ubuntu 26.04</td><td>Cloud infrastructure</td></tr>
        <tr><td>GitHub</td><td>-</td><td>Source code management & webhooks</td></tr>
        <tr><td>Jenkins</td><td>2.555+</td><td>CI/CD automation server</td></tr>
        <tr><td>Apache Maven</td><td>3.9.12</td><td>Build tool & dependency management</td></tr>
        <tr><td>JUnit</td><td>4.13.2</td><td>Unit testing framework</td></tr>
        <tr><td>JaCoCo</td><td>0.8.11</td><td>Code coverage reporting</td></tr>
        <tr><td>SonarQube</td><td>10.6 Community</td><td>Code quality & security analysis</td></tr>
        <tr><td>Apache Tomcat</td><td>10.1.56</td><td>Java servlet container</td></tr>
        <tr><td>Java</td><td>OpenJDK 21</td><td>Runtime environment</td></tr>
      </tbody>
    </table>
  </div>

  <!-- Pipeline Stages -->
  <div class="card-dark p-4 mb-4">
    <h4 class="section-title">⚙️ Pipeline Stages</h4>
    <table class="table table-dark table-bordered">
      <thead>
        <tr><th>#</th><th>Stage</th><th>What happens</th></tr>
      </thead>
      <tbody>
        <tr><td>1</td><td>📦 Checkout</td><td>Jenkins pulls latest code from GitHub via webhook trigger</td></tr>
        <tr><td>2</td><td>🔨 Build</td><td>Maven compiles source code and packages as WAR file</td></tr>
        <tr><td>3</td><td>🧪 Test & Coverage</td><td>19 unit tests run, JaCoCo generates coverage report (54%+)</td></tr>
        <tr><td>4</td><td>🔍 SonarQube Analysis</td><td>Static code analysis for bugs, smells, security hotspots</td></tr>
        <tr><td>5</td><td>🚦 Quality Gate</td><td>Pipeline fails if code quality doesn't meet thresholds</td></tr>
        <tr><td>6</td><td>🚀 Deploy</td><td>WAR deployed to Tomcat via Manager REST API</td></tr>
        <tr><td>7</td><td>🔥 Smoke Test</td><td>Automated HTTP check confirms app is live after deploy</td></tr>
      </tbody>
    </table>
  </div>

  <!-- Project Links -->
  <div class="card-dark p-4 mb-4">
    <h4 class="section-title">🔗 Project Links</h4>
    <div class="row g-3">
      <div class="col-md-4">
        <a href="http://100.49.158.149:8080" target="_blank" rel="noopener noreferrer"
           class="btn btn-primary w-100">⚙️ Jenkins Dashboard</a>
      </div>
      <div class="col-md-4">
        <a href="http://100.49.158.149:9000/dashboard?id=demo-webapp" target="_blank" rel="noopener noreferrer"
           class="btn btn-info w-100 text-dark">🔍 SonarQube Report</a>
      </div>
      <div class="col-md-4">
        <a href="https://github.com/kavvyaa1802/devops-project" target="_blank" rel="noopener noreferrer"
           class="btn w-100 text-white" style="background:#24292e">📦 GitHub Repository</a>
      </div>
    </div>
  </div>

</div>

<footer class="text-center mt-5">
  <div class="container">
    <span style="color:#60a5fa;font-weight:600;">Kavya Sri Nallani</span>
    <span style="color:#475569;margin:0 8px;">·</span>
    Final Year DevOps Project
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
</html>
