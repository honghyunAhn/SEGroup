package com.aracomm.base.common.customtag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import com.aracomm.base.common.util.CommonUtil;

/**
 * @author Park
 *
 */
@SuppressWarnings("serial")
public class PhoneFormatTag extends TagSupport {
	private String phone;

	public PhoneFormatTag() {
	}
	public int doStartTag() throws JspException {
		try {
			String [] s = CommonUtil.splitTel(phone);

			String val = phone;
			if (!"".equals(s[0]) && !"".equals(s[1]) && !"".equals(s[2])) {
				val = s[0] + "-" + s[1] + "-" + s[2];
			}

			pageContext.getOut().print(val);
		} catch (Exception ex) {
			throw new JspTagException("PhoneFormatTag " + ex.getMessage());
		}

		return SKIP_BODY;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}



}
