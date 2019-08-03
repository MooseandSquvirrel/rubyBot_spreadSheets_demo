#!/usr/env/bin ruby

require 'csv'

csvArray = CSV.read("csvHiBandNumbList.csv", {:col_sep => ', '})
p csvArray.flatten

