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
public class SelectedTag extends TagSupport {
	private String value;
	private String compareValue;
	private boolean nullsel = false;	// if compareValue is null, selected
	private String type = "S";	// S(elected), C(hecked)


	public int doStartTag() throws JspException {
		String selected = ("C".equals(type))?"checked='checked'":"selected='selected'";
		String str = "";
		try {
			if (value == null && compareValue == null) {
				str = selected;
			} else if (value == null) {
				str = "";
			} else if (compareValue == null) {
				if (nullsel) str = selected;
				else str = "";
			} else {
				if(value.equals(compareValue)) str = selected;
				else str = "";
			}
			pageContext.getOut().print(str);
		} catch (Exception ex) {
			throw new JspTagException("SelectedTag " + ex.getMessage());
		}

		return SKIP_BODY;
	}

	public void setValue(String value) {
		this.value = CommonUtil.unscript(value);
	}

	public void setCompareValue(String compareValue) {
		this.compareValue = compareValue;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setNullsel(boolean nullsel) {
		this.nullsel = nullsel;
	}


}
