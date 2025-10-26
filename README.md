# Sync Products Integration

A comprehensive MuleSoft integration project that automates the synchronization of product data across multiple systems including external APIs, databases, and Salesforce.

## 📋 Project Overview

This proof-of-concept (POC) demonstrates a robust integration solution that fetches product data from an external public API, transforms it using DataWeave, and synchronizes it across both a local database and Salesforce. The solution includes comprehensive logging, error handling, email notifications, and extensive MUnit test coverage.

## 🎯 Key Features

- **External API Integration**: Fetches product data from public APIs
- **Data Transformation**: Transforms JSON data using DataWeave to match target system requirements
- **Dual System Synchronization**: Inserts/updates data in both database and Salesforce
- **Intelligent Data Handling**: Checks for existing records and performs upsert operations
- **Comprehensive Logging**: Detailed logging throughout the integration flow for traceability
- **Error Handling**: Robust error handling with retry mechanisms using "Until Successful" scope
- **Email Notifications**: Automated email alerts upon successful data synchronization
- **Test Coverage**: Extensive MUnit test cases with high coverage (96-100%)

## 🏗️ Architecture

This project follows MuleSoft's API-led connectivity approach with three layers:

### 1. **Process API (PAPI)** - `sync-products-integration-papi`
The orchestration layer that coordinates the entire integration flow.

**Main Flow Components:**
- Receives requests from external clients (e.g., Postman)
- Orchestrates calls to system APIs
- Manages business logic and data flow

**Sub-flows:**
- `fetching-Request-dataSub_Flow`: Fetches data from external API
- `checking-the-existing-data-subflow`: Validates if records exist in the database
- `inserting-data-into-db-subflow`: Handles database insertions with retry logic
- `calling-sf-subflow`: Manages Salesforce upsert operations with retry logic
- `sending-mail-Sub_Flow1`: Sends email notifications with processed data

### 2. **System API (SAPI)** - `sync-products-integration-db-sapi`
Handles all database operations.

**Endpoints:**
- `POST /creatingRecorddb`: Insert new records
- `PUT /creatingRecorddb/{id}`: Update existing records
- `GET /creatingRecorddb/{id}`: Retrieve records by ID

**Sub-flows:**
- `db-insertionSub_Flow`: Database insertion logic
- `db-updation-subflow`: Database update operations
- `db-implementationsSub_Flow`: Core database operations (Insert, Update, Select)

### 3. **System API (SAPI)** - `sync-products-integration-sf-sapi`
Manages all Salesforce operations.

**Endpoints:**
- `POST /creatingRecorssf`: Create/upsert Salesforce records

**Sub-flows:**
- `sf-creatingdataSub_Flow`: Handles Salesforce upsert operations using DataWeave transformations

### 4. **System API (SAPI)** - `sync-products-integration-mail-sapi`
Handles email notification operations.

## 🔄 Integration Flow

```
1. Postman/Client Request → Process API (PAPI)
2. PAPI → Fetch data from External API
3. PAPI → Check existing IDs in Database
4. PAPI → Decision: Insert or Update?
   ├─ Insert → Database SAPI (New Records)
   └─ Update → Database SAPI (Existing Records)
5. PAPI → Upsert to Salesforce SAPI
6. PAPI → Send Email Notification with Results
7. PAPI → Return Response to Client
```

## 🛠️ Technologies Used

- **MuleSoft Anypoint Studio**: Development environment
- **MuleSoft Runtime**: Mule 4.x
- **DataWeave**: Data transformation
- **APIkit**: REST API scaffolding
- **Database Connector**: PostgreSQL/SQL database integration
- **Salesforce Connector**: Salesforce integration with OAuth
- **Email Connector**: SMTP email notifications
- **MUnit**: Unit testing framework
- **RAML**: API specification

## 📦 Project Structure

```
sync-products-integration/
├── sync-products-integration-papi/
│   ├── src/main/mule/
│   │   ├── sync-product-integration-papi.xml
│   │   ├── fetching-Request-data.xml
│   │   ├── global-config.xml
│   │   └── global-error-handler.xml
│   ├── src/main/resources/
│   │   ├── application-types.xml
│   │   ├── devproperties/dev.yaml
│   │   └── weave/
│   └── src/test/munit/
│       └── fetching-Request-data-test-suite.xml
│
├── sync-products-integration-db-sapi/
│   ├── src/main/mule/
│   │   ├── sync-products-integration-db-sapi.xml
│   │   ├── global-config.xml
│   │   └── global-error.xml
│   └── src/test/munit/
│
├── sync-products-integration-sf-sapi/
│   ├── src/main/mule/
│   │   ├── sync-product-integration-sf-sapi.xml
│   │   ├── sf-creatingdata.xml
│   │   ├── global-config.xml
│   │   └── global-error-handlers.xml
│   └── src/test/munit/
│       └── sync-product-integration-sf-sapi-suite.xml
│
└── sync-products-integration-mail-sapi/
    ├── src/main/mule/
    │   ├── sync-product-integration-mail-sapi.xml
    │   ├── sendmail.xml
    │   └── global-config.xml
    └── src/main/resources/
        └── properties/dev.yaml
```

## 🚀 Getting Started

### Prerequisites

- MuleSoft Anypoint Studio 7.x or higher
- Java JDK 8 or 11
- Access to a database (PostgreSQL/MySQL)
- Salesforce Developer account with OAuth credentials
- SMTP server access for email notifications

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/sync-products-integration.git
   cd sync-products-integration
   ```

2. **Import projects into Anypoint Studio**
   - Open Anypoint Studio
   - File → Import → Anypoint Studio → Packaged mule application (.jar)
   - Import all four projects

3. **Configure properties files**
   
   Update `dev.yaml` in each project with your credentials:
   
   **Database Configuration:**
   ```yaml
   db:
     host: your-database-host
     port: 5432
     database: your-database-name
     username: your-username
     password: your-password
   ```
   
   **Salesforce Configuration:**
   ```yaml
   sfdc:
     username: your-salesforce-username
     password: your-salesforce-password
     securityToken: your-security-token
     clientId: your-connected-app-client-id
     clientSecret: your-connected-app-client-secret
   ```
   
   **Email Configuration:**
   ```yaml
   smtp:
     host: smtp.gmail.com
     port: 587
     username: your-email@gmail.com
     password: your-app-password
   ```

4. **Setup Database**
   
   Create the products table:
   ```sql
   CREATE TABLE products (
     id INTEGER PRIMARY KEY,
     title TEXT,
     price NUMERIC,
     description TEXT
   );
   ```

5. **Deploy Applications**
   - Run each application in Anypoint Studio
   - Ensure all applications start without errors

## 📝 API Endpoints

### Process API (PAPI)
- **Base URL**: `http://localhost:8081/api`
- **GET** `/fetchdata` - Trigger the product synchronization flow

### Database System API
- **Base URL**: `http://localhost:8082/api`
- **POST** `/creatingRecorddb` - Insert new product
- **PUT** `/creatingRecorddb/{id}` - Update existing product
- **GET** `/creatingRecorddb/{id}` - Get product by ID

### Salesforce System API
- **Base URL**: `http://localhost:8083/api`
- **POST** `/creatingRecorssf` - Upsert product to Salesforce

### Mail System API
- **Base URL**: `http://localhost:8084/api`
- **POST** `/sendmail` - Send email notification

## 🧪 Testing

### Running MUnit Tests

1. **Right-click on the test suite file**
2. **Select "Run MUnit Suite"**

### Test Coverage Results

| API | Coverage | Status |
|-----|----------|--------|
| sync-products-integration-sf-sapi | 100% | ✅ Passed |
| sync-products-integration-db-sapi | 96.15% | ✅ Passed |
| sync-products-integration-papi | Testing Implemented | ✅ Passed |

### Sample Test Execution

```bash
# Run all MUnit tests
mvn clean test
```

## 📧 Email Notification

Upon successful completion, an email is sent with:
- Summary of processed records
- Database insertion results
- Salesforce upsert results
- Attached CSV file with product details

**Sample Response:**
```json
{
  "message": "check your mail for the id"
}
```

## 🔍 Monitoring & Logging

Each flow includes comprehensive logging:
- Entry and exit points
- Request/response payloads
- Error tracking
- Performance metrics

**Log Levels:**
- INFO: Standard flow execution
- DEBUG: Detailed payload information
- ERROR: Exception and error details

## 📊 Sample Output

### Postman Response
```json
{
  "message": "check your mail for the id"
}
```

### Database Output
| id | title | price | description |
|----|-------|-------|-------------|
| 1 | Fjallraven Foldsack | 109.95 | Your perfect... |
| 10 | SanDisk SSD PLUS 1TB | 109 | Easy upgrade... |
| 11 | Silicon Power 256GB | 109 | 3D NAND... |

### Salesforce Output
Records created/updated in Salesforce with product information synchronized from the database.

## ⚠️ Error Handling

The integration implements multiple error handling strategies:

- **Until Successful Scope**: Automatic retry for transient failures
- **Global Error Handlers**: Centralized error processing
- **Custom Error Responses**: Meaningful error messages
- **Transaction Management**: Rollback on critical failures

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👤 Author

**Your Name**
- Email: gopivarri1@gmail.com
- GitHub: [@yourusername](https://github.com/yourusername)

## 🙏 Acknowledgments

- MuleSoft Community for best practices and guidance
- Salesforce Developer Network for API documentation
- External API providers for test data

## 📞 Support

For issues, questions, or contributions, please open an issue in the GitHub repository.

---

**Note**: This is a POC project demonstrating MuleSoft integration capabilities. Ensure proper security measures and error handling are implemented before deploying to production environments.