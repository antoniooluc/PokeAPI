export interface Pokemon {
  name: string
  url: string
  tipos: string[]
}

export interface PokemonResponse {
  count: number
  next: string | null
  previous: string | null
  results: Pokemon[]
}

export interface PokemonType {
  type: PokemonTypeName
}

export interface PokemonTypeName {
  name: string
}