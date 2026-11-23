/** Create an element with text (never HTML: content comes from an editor, so it is data). */
export function el(tag, attrs = {}, ...children) {
  const node = document.createElement(tag);
  for (const [key, value] of Object.entries(attrs)) {
    if (value === false || value == null) continue;
    if (key === 'class') node.className = value;
    else node.setAttribute(key, value === true ? '' : String(value));
  }
  for (const child of children.flat()) {
    node.append(child instanceof Node ? child : document.createTextNode(String(child)));
  }
  return node;
}
