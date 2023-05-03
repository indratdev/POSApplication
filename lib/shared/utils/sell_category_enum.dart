enum SellCategoryBy {
  unit,
  fractionkg,
}

SellCategoryBy convertToEnum(String value) {
  if (value.toLowerCase() == "unit") {
    return SellCategoryBy.unit;
  } else if (value.toLowerCase() == "fractionkg") {
    return SellCategoryBy.fractionkg;
  } else {
    return SellCategoryBy.unit;
  }
}
