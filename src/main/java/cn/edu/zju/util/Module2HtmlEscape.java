package cn.edu.zju.util;

import java.util.regex.Pattern;

/**
 * ICA3 Module 2 — minimal HTML escaping + case-insensitive keyword highlight.
 * <p>
 * Report angle: prevents XSS (search keyword echoed into HTML must be escaped first);
 * {@code &lt;mark&gt;} is only inserted after escaping both the field text and the keyword.
 */
public final class Module2HtmlEscape {

    private Module2HtmlEscape() {
    }

    public static String escapeHtml(String raw) {
        if (raw == null) {
            return "";
        }
        return raw.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    /**
     * {@code text} is plain text from DB; {@code keyword} is user input. Returns safe HTML string.
     */
    public static String escapeAndHighlight(String text, String keyword) {
        String escaped = escapeHtml(text);
        if (keyword == null) {
            return escaped;
        }
        String trimmed = keyword.trim();
        if (trimmed.isEmpty()) {
            return escaped;
        }
        String needle = escapeHtml(trimmed);
        if (needle.isEmpty()) {
            return escaped;
        }
        return escaped.replaceAll("(?i)" + Pattern.quote(needle), "<mark>$0</mark>");
    }
}
