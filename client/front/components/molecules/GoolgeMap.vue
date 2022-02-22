<template>
  <div>
    <GmapMap
      :center="{ lat: location.lat, lng: location.lng }"
      :zoom="7"
      map-type-id="terrain"
      style="width: 100%; height: 350px"
    >
    </GmapMap>
  </div>
</template>

<script>
export default {
  props: {
    location: {
      type: Object,
      required: true,
    },
  },
}
</script>
