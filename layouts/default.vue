<template>
  <div class="flex flex-col min-h-screen">
    
    <header class="bg-red-500 text-white p-4 mb-8 flex justify-between items-center shadow-md">
      <h1 class="text-xl font-bold">PokeAPI</h1>
      <nav>
        <NuxtLink to="/" class="hover:underline text-xl">Inicio</NuxtLink>
      </nav>
    </header>

    <main class="flex-1 container mx-auto p-4 text-center text-lg ">
      <slot />
    </main>

    <footer class="bg-gray-100 text-gray-600 text-center p-8 mt-8 border-t">
      <p>© 2025 - PokeAPI | Datos de <a href="https://pokeapi.co" target="_blank" class="underline">PokéAPI</a></p>
    </footer>

  </div>
</template>