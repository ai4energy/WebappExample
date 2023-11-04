<template>
    <div>
      <button @click="makeRequest">发起请求</button>
      <p v-if="result !== null">结果: {{ result }}</p>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref } from 'vue';
  import axios from 'axios';
  
  const result = ref<string | null>(null);
  
  const makeRequest = async () => {
    try {
      const response = await axios.get('/api/add/2/4');
      result.value = response.data.toString();
    } catch (error) {
      console.error(error);
    }
  };
  </script>
  