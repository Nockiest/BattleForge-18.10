const totalTypes = {
  VIEWS: 2,
  READS: 3,
  FANS: 5
};
const getTotal = tableColumn =>
  [
    ...document.querySelectorAll(
      `td:nth-child(${tableColumn}) > span.sortableTable-number`
    )
  ]
    .map(e => parseInt(e.getAttribute("title").replace(/,/g, ""), 10))
    .reduce((a, b) => a + b, 0);
console.log({
  totalViews: getTotal(totalTypes.VIEWS),
  totalReads: getTotal(totalTypes.READS),
  totalFans: getTotal(totalTypes.FANS)
});