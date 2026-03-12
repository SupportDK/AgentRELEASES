<?php
/**
 * Plugin Name: WPC Hello World
 * Plugin URI:  https://wpconnect.co
 * Description: A minimal Hello World plugin for testing the WP connect AI development pipeline.
 * Version:     1.0.0
 * Author:      WP connect
 * Author URI:  https://wpconnect.co
 * License:     GPL-2.0-or-later
 * Text Domain: wpc-hello-world
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

/**
 * Display a Hello World admin notice.
 */
function wpc_hello_world_admin_notice() {
	?>
	<div class="notice notice-success">
		<p><?php esc_html_e( 'Hello World — WPC Hello World plugin is active.', 'wpc-hello-world' ); ?></p>
	</div>
	<?php
}
add_action( 'admin_notices', 'wpc_hello_world_admin_notice' );
