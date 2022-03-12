<?php
// Check to make sure the id parameter is specified in the URL
if (isset($_GET['id'])) {
    // Prepare statement and execute, prevents SQL injection
    $stmt = $pdo->prepare('SELECT * FROM products WHERE id = ?');
    $stmt->execute([$_GET['id']]);
    // Fetch the product from the database and return the result as an Array
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
    // Check if the product exists (array is not empty)
    if (!$product) {
        // Simple error to display if the id for the product doesn't exists (array is empty)
        die ('Product does not exist!');
    }
    // Select the product images (if any) from the product_images table
    $stmt = $pdo->prepare('SELECT * FROM products_images WHERE product_id = ?');
    $stmt->execute([$_GET['id']]);
    // Fetch the product images from the database and return the result as an Array
    $product_imgs = $stmt->fetchAll(PDO::FETCH_ASSOC);
} else {
    // Simple error to display if the id wasn't specified
    die ('Product does not exist!');
}
?>

<?=template_header('Product')?>

<div class="product content-wrapper">
    <div class="product-imgs">
        <img class="product-img-large" src="imgs/<?=$product['img']?>" width="500" height="500" alt="<?=$product['name']?>">
        <div class="product-small-imgs">
            <img class="product-img-small selected" src="imgs/<?=$product['img']?>" width="150" height="150" alt="<?=$product['name']?>">
            <?php foreach ($product_imgs as $product_img): ?>
            <img class="product-img-small" src="imgs/<?=$product_img['img']?>" width="150" height="150" alt="<?=$product['name']?>">
            <?php endforeach; ?>
        </div>
    </div>
    <div class="product-wrapper">
        <h1 class="name"><?=$product['name']?></h1>
        <span class="price">
            &dollar;<?=$product['price']?>
            <?php if ($product['rrp'] > 0): ?>
            <span class="rrp">&dollar;<?=$product['rrp']?></span>
            <?php endif; ?>
        </span>
        <form action="index.php?page=cart" method="post">
            <input type="number" name="quantity" value="1" min="1" max="<?=$product['quantity']?>" placeholder="Quantity" required>
            <input type="hidden" name="product_id" value="<?=$product['id']?>">
            <input type="submit" value="Add To Cart">
        </form>
        <div class="description">
            <?=$product['desc']?>
        </div>
    </div>
</div>

<?=template_footer()?>
