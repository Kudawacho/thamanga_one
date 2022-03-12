<?php
// Function that will connect to the MySQL database
function pdo_connect_mysql() {
    try {
        // Connect to the MySQL database using PDO...
    	return new PDO('mysql:host=' . db_host . ';dbname=' . db_name . ';charset=utf8', db_user, db_pass);
    } catch (PDOException $exception) {
    	// Could not connect to the MySQL database, if this error occurs make sure you check your db settings are correct!
    	exit('Failed to connect to database!');
    }
}
// Function to retrieve a product from cart by the ID and options string
function &get_cart_product($id, $options) {
    $p = null;
    if (isset($_SESSION['cart'])) {
        foreach ($_SESSION['cart'] as &$product) {
            if ($product['id'] == $id && $product['options'] == $options) {
                $p = &$product;
                return $p;
            }
        }
    }
    return $p;
}
// Send order details email function
function send_order_details_email($email, $products, $first_name, $last_name, $address_street, $address_city, $address_state, $address_zip, $address_country, $subtotal, $order_id) {
    if (!mail_enabled) {
        return;
    }
	$subject = 'Order Details';
	$headers = 'From: ' . mail_from . "\r\n" . 'Reply-To: ' . mail_from . "\r\n" . 'Return-Path: ' . mail_from . "\r\n" . 'X-Mailer: PHP/' . phpversion() . "\r\n" . 'MIME-Version: 1.0' . "\r\n" . 'Content-Type: text/html; charset=UTF-8' . "\r\n";
    ob_start();
    include 'order-details-template.php';
    $order_details_template = ob_get_clean();
	mail($email, $subject, $order_details_template, $headers);
}
// Template header, feel free to customize this
function template_header($title) {
// Get the amount of items in the shopping cart, this will be displayed in the header.
$num_items_in_cart = isset($_SESSION['cart']) ? count($_SESSION['cart']) : 0;
$site_name = site_name;
$admin_link = isset($_SESSION['account_loggedin']) && $_SESSION['account_admin'] ? '<a href="admin/index.php" target="_blank">Admin</a>' : '';
$logout_link = isset($_SESSION['account_loggedin']) ? '<a title="Logout" href="logout.php"><i class="fas fa-sign-out-alt"></i></a>' : '';
echo <<<EOT
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,minimum-scale=1">
		<title>$title</title>
        <link rel="icon" type="image/png" href="favicon.png">
		<link href="style.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
	</head>
	<body>
        <header>
            <div class="content-wrapper">
                <h1>$site_name</h1>
                <nav>
                    <a href="index.php">Home</a>
                    <a href="index.php?page=products">Products</a>
					<a href="index.php?page=myaccount">My Account</a>
                    $admin_link
                </nav>
                <div class="link-icons">
                    <div class="search">
						<i class="fas fa-search"></i>
						<input type="text" placeholder="Search...">
					</div>
                    <a href="index.php?page=cart" title="Shopping Cart">
						<i class="fas fa-shopping-cart"></i>
						<span>$num_items_in_cart</span>
					</a>
                    $logout_link
					<a class="responsive-toggle" href="#">
						<i class="fas fa-bars"></i>
					</a>
                </div>
            </div>
        </header>
        <main>
EOT;
}
// Template footer
function template_footer() {
$year = date('Y');
$currency_code = currency_code;
echo <<<EOT
        </main>
        <footer>
            <div class="content-wrapper">
                <p>&copy; $year, Shopping Cart System</p>
            </div>
        </footer>
        <script>
        let currency_code = "$currency_code";
        </script>
        <script src="script.js"></script>
    </body>
</html>
EOT;
}
// Template admin header
function template_admin_header($title) {
echo <<<EOT
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,minimum-scale=1">
		<title>$title</title>
        <link rel="icon" type="image/png" href="../favicon.png">
		<link href="admin.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
	</head>
	<body class="admin">
        <header>
            <h1>Shopping Cart Admin</h1>
            <a class="responsive-toggle" href="#">
                <i class="fas fa-bars"></i>
            </a>
        </header>
        <aside class="responsive-width-100 responsive-hidden">
            <a href="index.php?page=orders"><i class="fas fa-shopping-cart"></i>Orders</a>
            <a href="index.php?page=products"><i class="fas fa-box-open"></i>Products</a>
            <a href="index.php?page=categories"><i class="fas fa-list"></i>Categories</a>
            <a href="index.php?page=accounts"><i class="fas fa-users"></i>Accounts</a>
            <a href="index.php?page=shipping"><i class="fas fa-shipping-fast"></i>Shipping</a>
            <a href="index.php?page=images"><i class="fas fa-images"></i>Upload Images</a>
            <a href="index.php?page=emailtemplates"><i class="fas fa-envelope"></i>Email Templates</a>
            <a href="index.php?page=settings"><i class="fas fa-tools"></i>Settings</a>
            <a href="index.php?page=logout"><i class="fas fa-sign-out-alt"></i>Log Out</a>
        </aside>
        <main class="responsive-width-100">
EOT;
}
// Template admin footer
function template_admin_footer() {
echo <<<EOT
        </main>
        <script>
        document.querySelector(".responsive-toggle").onclick = function(event) {
            event.preventDefault();
            let aside_display = document.querySelector("aside").style.display;
            document.querySelector("aside").style.display = aside_display == "flex" ? "none" : "flex";
        };
        </script>
    </body>
</html>
EOT;
}
?>
