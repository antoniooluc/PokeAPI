<template>
  <div>

    <div id="introduccion">
      <h1 class="text-2xl font-bold mb-4 mt-6">Listado de Pokémons</h1>
      <p class="mb-6">
        Aplicación web la cual muestra el aspecto y el tipo de todos los Pokemon
      </p>
    </div>

    <div id="contenido" class="mt-8">
      <div v-if="pending"></div>
      <div v-else-if="error">Error al cargar los datos</div>
      <div v-else>

        <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-6">
          <div v-for="pokemon in data?.results" :key="pokemon.name" class="bg-white shadow-md border rounded-xl p-4 flex flex-col items-center hover:shadow-xl transition">
            
            <img :src="`https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${getIdFromUrl(pokemon.url)}.png`"
              :alt="pokemon.name"
              class="w-20 h-20 mb-3"
            />

            <h2 class="text-lg font-semibold capitalize">{{ pokemon.name }}</h2>
            <p class="text-sm text-gray-600 capitalize">
              {{ pokemon.tipos.join(', ') }}
            </p>
          </div>
        </div>

        <div class="flex justify-center gap-4 mt-12 text-white font-semibold">
          <button class="bg-red-500 px-6 py-2 rounded-lg w-40 hover:bg-red-800 transition disabled:bg-gray-400 disabled:cursor-not-allowed" :disabled="!data?.previous" @click="anterior">
            Anterior
          </button>
          <button class="bg-red-500 px-6 py-2 rounded-lg w-40 hover:bg-red-800 transition disabled:bg-gray-400 disabled:cursor-not-allowed" :disabled="!data?.next" @click="siguiente">
            Siguiente
          </button>
        </div>

      </div>

    </div>

  </div>
</template>

<script setup lang="ts">
  import type { PokemonResponse, PokemonType } from '~/types/pokemon'

  const cacheTipos = new Map<string, any>()

  const currentUrl = ref(`https://pokeapi.co/api/v2/pokemon?offset=0&limit=20`)

  const { data, pending, error } = await useFetch<PokemonResponse>(currentUrl, {key: currentUrl})

  function getIdFromUrl(url: string) {
    return url.split("/").filter(Boolean).pop();
  }

  function siguiente() {
    if (data.value?.next) {
      currentUrl.value = data.value.next
    }
  }

  function anterior() {
    if (data.value?.previous) {
      currentUrl.value = data.value.previous
    }
  }

  async function loadTipo() {
    if (!data.value?.results) return

    pending.value = true

    try {
      await Promise.all(
        data.value.results.map(async (pokemon) => {
          if (!cacheTipos.has(pokemon.url)){
            const detail = await $fetch<{ types: PokemonType[] }>(pokemon.url)
            const tipos = detail.types.map(typeSlot => typeSlot.type.name)
            cacheTipos.set(pokemon.url, tipos)
            pokemon.tipos = tipos
          } else {
            pokemon.tipos = cacheTipos.get(pokemon.url)
          }
        })
      )
    } catch (error) {
      
    } finally {
      pending.value = false
    }
  }

  watch(data, loadTipo, { immediate: true })

</script>
