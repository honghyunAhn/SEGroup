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
public class DateFormatTag extends TagSupport {
	private String datestr;
	private String fromformat;
	private String toformat;

	public DateFormatTag() {
		fromformat = "yyyyMMdd";
		toformat = "yyyy.MM.dd";
	}
	public int doStartTag() throws JspException {
		try {
			String val = CommonUtil.getFormatDate(datestr, fromformat, toformat);
			pageContext.getOut().print(val);
		} catch (Exception ex) {
			throw new JspTagException("DateFormatTag " + ex.getMessage());
		}

		return SKIP_BODY;
	}

	public void setDatestr(String datestr) {
		this.datestr = datestr;
	}

	public void setFromformat(String fromformat) {
		this.fromformat = fromformat;
	}

	public void setToformat(String toformat) {
		this.toformat = toformat;
	}



}
