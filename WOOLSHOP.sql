-- Tạo Cơ Sở Dữ Liệu
CREATE DATABASE Coloshop;

-- Sử dụng Cơ Sở Dữ Liệu vừa tạo
USE Coloshop;

-- Tạo bảng Danh Mục Sản Phẩm
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY,
    CategoryName NVARCHAR(100)
);

-- Tạo bảng Sản Phẩm
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100),
    Description NVARCHAR(255),
    Price DECIMAL(10, 2),
    Stock INT,
    CategoryID INT,
    ImageURL NVARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Tạo bảng Khách Hàng
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100),
    Email NVARCHAR(100),
    Address NVARCHAR(255),
	Phone NVARCHAR(10)
);

-- Tạo bảng Accounts
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(100) UNIQUE,
    Password NVARCHAR(100),
    CustomerID INT,
    Role NVARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Tạo bảng Blog
CREATE TABLE Blogs (
    BlogID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(255),
    Content NVARCHAR(MAX),
    AuthorID INT,
    PublishedDate DATETIME,
    CategoryID INT,
    FOREIGN KEY (AuthorID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Tạo bảng Phương Thức Thanh Toán
CREATE TABLE PaymentMethods (
    PaymentMethodID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(50),
	Discription NVARCHAR(255)
);

-- Tạo bảng Đơn Đặt Hàng
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10, 2),
    PaymentMethodID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID)
);

-- Tạo bảng Chi Tiết Đơn Hàng
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tạo bảng Nhà Cung Cấp
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100),
    ContactEmail NVARCHAR(100),
    ContactPhone NVARCHAR(15),
    Address NVARCHAR(255)
);

-- Tạo bảng Nhập Kho
CREATE TABLE InventoryReceipts (
    ReceiptID INT PRIMARY KEY IDENTITY,
    SupplierID INT,
    ReceiptDate DATETIME,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Tạo bảng Chi Tiết Nhập Kho
CREATE TABLE InventoryDetails (
    InventoryDetailID INT PRIMARY KEY IDENTITY,
    ReceiptID INT,
    ProductID INT,
    Quantity INT,
    PurchasePrice DECIMAL(10, 2),
    FOREIGN KEY (ReceiptID) REFERENCES InventoryReceipts(ReceiptID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tạo bảng Đánh Giá Sản Phẩm
CREATE TABLE ProductReviews (
    ReviewID INT PRIMARY KEY IDENTITY,
    ProductID INT,
    CustomerID INT,
    Rating INT,
    Comment NVARCHAR(255),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

