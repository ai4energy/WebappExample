<template>
    <div>
    <input v-model="num1" type="number" placeholder="输入整数1" id="num1"/>
    <input v-model="num2" type="number" placeholder="输入整数2" id="num2"/>
      <button @click="makeRequest">计算差值</button>
      <p>结果: {{ result }}</p>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref } from 'vue';
  import axios from 'axios';
  const num1 = ref(0);
  const num2 = ref(0);
  
  const result = ref(null);
 
const makeRequest = () => {

  const num1Value = num1.value;
  const num2Value = num2.value;

  if (Number.isInteger(num1Value) && Number.isInteger(num2Value)){
    console.log(num1Value);
    console.log(num2Value);
  axios.get(`/api/sub/${num1Value}/${num2Value}`)
    .then((response) => {
      const resultValue = response.data.toString();
      result.value=resultValue;
      console.log(resultValue);
    })
    .catch((error) => {
      console.error(error);
    });
  };
};


  </script>
  