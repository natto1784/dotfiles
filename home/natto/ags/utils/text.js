export const shrinkText = (str, n) => {
  let newStr = str.substring(0, n);
  if (str.length > n) newStr = newStr + "...";
  return newStr;
};
