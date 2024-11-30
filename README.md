# Terraform-Portfolio-Project
I am building a static content in S3 and pushing it through cloudfront using Terraform (IAC) automate and manage Infrastructure.





## Detailed Report on Portfolio Project - Terraform  

### Project Overview  

**Client:** James Smith, Freelance Web Designer  
**Project Title:** Portfolio Website Deployment  

**Objective:** Deploy a responsive, modern single-page portfolio website designed using the Next.js framework. The goal is to ensure that the website is highly available, scalable, cost-effective, and fast-loading for a global audience, leveraging AWS services and Terraform for deployment.  

**Role:** Cloud Engineers deploying the infrastructure using Infrastructure as Code (IaC) principles with Terraform.  

---

### Problem Statement  

James requires a robust platform to showcase his work and attract potential clients. The website must meet the following requirements:  
1. **High Availability:** Ensure the website is accessible globally with minimal downtime.  
2. **Scalability:** Accommodate increased traffic as the portfolio gains traction without compromising performance.  
3. **Cost-Effectiveness:** Optimize hosting costs, avoiding unnecessary expenses.  
4. **Fast Loading Times:** Deliver quick loading speeds to enhance the user experience.  

The chosen solution involves deploying the website on AWS using S3 for static hosting, CloudFront for content delivery, and automating infrastructure creation with Terraform.  

---

### Project Outcome  

By the end of this project, the following deliverables will be achieved:  
1. **Deployment of Next.js Website:** Successful hosting of James's portfolio site on AWS.  
2. **Infrastructure as Code Implementation:** Automated creation and management of AWS resources using Terraform.  
3. **Global Content Delivery:** Utilization of AWS CloudFront to ensure low-latency content delivery.  
4. **Enhanced Security and Performance:** Application of best practices for a secure and high-performing website.  
5. **GitHub Repository:** Project files and code hosted in a public GitHub repository for reference and future use.  

---

### Next.js Overview  

#### What is Next.js?  
Next.js is a framework built on React that simplifies the creation of fast, scalable, and SEO-friendly web applications.  

**Key Features:**  
- **Server-Side Rendering (SSR):** Enhances SEO and initial load times by generating pages on the server.  
- **Static Site Generation (SSG):** Pre-renders pages at build time for faster performance.  
- **API Routes:** Built-in support for serverless functions and API endpoints.  
- **File-Based Routing:** Simplified navigation using a folder-based structure.  
- **CSS/Sass Support:** Seamless integration of styling options.  
- **Automatic Code Splitting:** Optimized load times by serving only required JavaScript files.  

**Common Use Cases:** Static websites, e-commerce platforms, corporate websites, and blogs.  

---

### Deployment Plan  

#### **Step 1: Prepare the Next.js Application**  

1. **Create a GitHub Repository:**  
   - Name the repository `terraform-portfolio-project`.  
   - Initialize with a README file.  
   - Clone to local development environment.  

2. **Set Up Next.js Starter Kit:**  
   - Use `npx create-next-app` to initialize the project.  
   - Update `next.config.js` to include the following configuration:  

     ```javascript
     const nextConfig = {
       output: 'export',
     }
     module.exports = nextConfig;
     ```  
   - Generate the `out` folder using `npm run build`.  

3. **Version Control:**  
   - Initialize Git, add files, and push changes to GitHub.  

4. **Documentation:**  
   - Record a Loom video explaining the code structure and include the link in the README file.  

---

#### **Step 2: Set Up Terraform Configuration**  

1. **Initialize Terraform Directory:**  
   - Create a directory `terraform-nextjs`.  

2. **Key Terraform Files:**  
   - **State File:** Use S3 and DynamoDB for remote state management.  
   - **Main Configuration:**  
     - Configure AWS provider.  
     - Create AWS S3 bucket for hosting static files.  
     - Define S3 bucket policy for public access.  
     - Set up CloudFront distribution for content delivery with properties such as:  
       - **Origin:** S3 bucket domain.  
       - **Cache Behavior:** Optimize for `GET` and `HEAD` methods.  
       - **Viewer Protocol Policy:** Redirect HTTP to HTTPS.  

3. **Outputs File:**  
   - Output S3 bucket name and CloudFront distribution domain for easy access.  

4. **Execution:**  
   - Run `terraform init`, `terraform plan`, and resolve any issues.  
   - Apply the configuration using `terraform apply`.  

---

#### **Step 3: Upload Static Files to S3**  
Use AWS CLI to sync the Next.js output folder with the S3 bucket:  

```bash
aws s3 sync ../blog/out s3://<your-bucket-name>
```  

---

#### **Step 4: Access the Deployed Website**  
Retrieve the CloudFront URL using Terraform:  

```bash
terraform output cloudfront_url
```  
Open the URL in a browser to verify the deployment.  

---

### Challenges and Solutions  

1. **Terraform Configuration Issues:**  
   - Double-checked AWS Terraform documentation for syntax and property configurations.  

2. **Bucket Policy Errors:**  
   - Debugged using AWS S3 policy generators and applied corrections.  

3. **Static File Syncing:**  
   - Ensured accurate path configurations during S3 sync operations.  

---

### Summary  

This project successfully deployed James Smith’s portfolio website using Terraform, AWS S3, and CloudFront. The infrastructure is automated, scalable, and secure, delivering a globally optimized web experience. By documenting and hosting the project on GitHub, it provides a valuable reference for future implementations.  

#### Future Enhancements  
- Incorporate monitoring using AWS CloudWatch.  
- Explore cost optimization strategies with AWS budgets.  

**GitHub Repository:** [Link to Repository](#)  
 

 


