# Создают константы-валюты, типа RUB, USD и тп
Money::Currency.all.each do |cur|
  Object.const_set cur.iso_code, cur
end
