package com.aracomm.changbi.payment;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class KCPConfig {
	@Value("#{config['kcp.g_conf_log_dir']}")
	private String g_conf_log_dir;
	@Value("#{config['kcp.g_conf_gw_url']}")
	private String g_conf_gw_url;
	@Value("#{config['kcp.g_conf_js_url']}")
	private String g_conf_js_url;
	@Value("#{config['kcp.g_conf_server']}")
	private boolean g_conf_server;
	@Value("#{config['kcp.g_conf_site_cd']}")
	private String g_conf_site_cd;
	@Value("#{config['kcp.g_conf_site_key']}")
	private String g_conf_site_key;
	@Value("#{config['kcp.g_conf_site_name']}")
	private String g_conf_site_name;
	@Value("#{config['kcp.g_conf_log_level']}")
	private String g_conf_log_level;
	@Value("#{config['kcp.g_conf_gw_port']}")
	private String g_conf_gw_port;
	@Value("#{config['kcp.module_type']}")
	private String module_type;
	@Value("#{config['kcp.g_conf_tx_mode']}")
	private int g_conf_tx_mode;

	public String getG_conf_log_dir() {
		return g_conf_log_dir;
	}
	public void setG_conf_log_dir(String g_conf_log_dir) {
		this.g_conf_log_dir = g_conf_log_dir;
	}
	public String getG_conf_gw_url() {
		return g_conf_gw_url;
	}
	public void setG_conf_gw_url(String g_conf_gw_url) {
		this.g_conf_gw_url = g_conf_gw_url;
	}
	public String getG_conf_js_url() {
		return g_conf_js_url;
	}
	public void setG_conf_js_url(String g_conf_js_url) {
		this.g_conf_js_url = g_conf_js_url;
	}
	public boolean isG_conf_server() {
		return g_conf_server;
	}
	public void setG_conf_server(boolean g_conf_server) {
		this.g_conf_server = g_conf_server;
	}
	public String getG_conf_site_cd() {
		return g_conf_site_cd;
	}
	public void setG_conf_site_cd(String g_conf_site_cd) {
		this.g_conf_site_cd = g_conf_site_cd;
	}
	public String getG_conf_site_key() {
		return g_conf_site_key;
	}
	public void setG_conf_site_key(String g_conf_site_key) {
		this.g_conf_site_key = g_conf_site_key;
	}
	public String getG_conf_site_name() {
		return g_conf_site_name;
	}
	public void setG_conf_site_name(String g_conf_site_name) {
		this.g_conf_site_name = g_conf_site_name;
	}
	public String getG_conf_log_level() {
		return g_conf_log_level;
	}
	public void setG_conf_log_level(String g_conf_log_level) {
		this.g_conf_log_level = g_conf_log_level;
	}
	public String getG_conf_gw_port() {
		return g_conf_gw_port;
	}
	public void setG_conf_gw_port(String g_conf_gw_port) {
		this.g_conf_gw_port = g_conf_gw_port;
	}
	public String getModule_type() {
		return module_type;
	}
	public void setModule_type(String module_type) {
		this.module_type = module_type;
	}
	public int getG_conf_tx_mode() {
		return g_conf_tx_mode;
	}
	public void setG_conf_tx_mode(int g_conf_tx_mode) {
		this.g_conf_tx_mode = g_conf_tx_mode;
	}


}
