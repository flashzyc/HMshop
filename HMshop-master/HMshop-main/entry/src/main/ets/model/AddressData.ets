export interface AreaData {
  area: string
  code: string
}

export interface CityData {
  city: string
  code: string
  areas: AreaData[]
}

export interface ProvinceData {
  province: string
  code: string
  citys: CityData[]
}

export interface SelectedAddress {
  province: string
  city: string
  county: string
}