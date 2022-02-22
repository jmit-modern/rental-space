<template>
  <div>
    <div class="pt-20 text-center text-3xl font-bold mb-12 text-primary">
      {{ $t('top.popularArea.title') }}
    </div>
    <div class="grid grid-cols-3 gap-6 px-4">
      <nuxt-link to="/space?area=16">
        <div class="relative">
          <img
            src="https://himitsukichi.s3.ap-northeast-1.amazonaws.com/areas/pref_osaka.jpg"
            alt=""
            class="w-full"
          />
          <div
            class="
              absolute
              top-1/2
              left-1/2
              transform
              -translate-x-1/2 -translate-y-1/2
              text-2xl text-center
              py-3
              font-bold
              w-full
              tracking-widest
              bg-white bg-opacity-75
              text-secondary
            "
          >
            {{ $t('top.popularArea.osaka') }}
          </div>
        </div>
      </nuxt-link>
      <nuxt-link to="/space?area=15">
        <div class="relative">
          <img
            src="https://himitsukichi.s3.ap-northeast-1.amazonaws.com/areas/pref-kyoto.jpg"
            alt=""
            class="w-full"
          />
          <div
            class="
              absolute
              top-1/2
              left-1/2
              transform
              -translate-x-1/2 -translate-y-1/2
              text-2xl text-center
              py-3
              font-bold
              w-full
              tracking-widest
              bg-white bg-opacity-75
              text-secondary
            "
          >
            {{ $t('top.popularArea.kyoto') }}
          </div>
        </div>
      </nuxt-link>
      <nuxt-link to="/space?area=17">
        <div class="relative">
          <img
            src="https://himitsukichi.s3.ap-northeast-1.amazonaws.com/areas/pref-hyogo.jpg"
            alt=""
            class="w-full"
          />
          <div
            class="
              absolute
              top-1/2
              left-1/2
              transform
              -translate-x-1/2 -translate-y-1/2
              text-2xl text-center
              py-3
              font-bold
              w-full
              tracking-widest
              bg-white bg-opacity-75
              text-secondary
            "
          >
            {{ $t('top.popularArea.hyogo') }}
          </div>
        </div>
      </nuxt-link>
      <nuxt-link to="/space?area=7">
        <div class="relative">
          <img
            src="https://himitsukichi.s3.ap-northeast-1.amazonaws.com/areas/pref-tokyo.jpg"
            alt=""
            class="w-full"
          />
          <div
            class="
              absolute
              top-1/2
              left-1/2
              transform
              -translate-x-1/2 -translate-y-1/2
              text-2xl text-center
              py-3
              font-bold
              w-full
              tracking-widest
              bg-white bg-opacity-75
              text-secondary
            "
          >
            {{ $t('top.popularArea.tokyo') }}
          </div>
        </div>
      </nuxt-link>
      <nuxt-link to="/space?area=8">
        <div class="relative">
          <img
            src="https://himitsukichi.s3.ap-northeast-1.amazonaws.com/areas/pref-kanagawa.jpg"
            alt=""
            class="w-full"
          />
          <div
            class="
              absolute
              top-1/2
              left-1/2
              transform
              -translate-x-1/2 -translate-y-1/2
              text-2xl text-center
              py-3
              font-bold
              w-full
              tracking-widest
              bg-white bg-opacity-75
              text-secondary
            "
          >
            {{ $t('top.popularArea.kanagawa') }}
          </div>
        </div>
      </nuxt-link>

      <nuxt-link to="/space?area=6">
        <div class="relative">
          <img
            src="https://himitsukichi.s3.ap-northeast-1.amazonaws.com/areas/pref-chiba.jpg"
            alt=""
            class="w-full"
          />
          <div
            class="
              absolute
              top-1/2
              left-1/2
              transform
              -translate-x-1/2 -translate-y-1/2
              text-2xl text-center
              py-3
              font-bold
              w-full
              tracking-widest
              bg-white bg-opacity-75
              text-secondary
            "
          >
            {{ $t('top.popularArea.chiba') }}
          </div>
        </div>
      </nuxt-link>
    </div>
  </div>
</template>

<script>
export default {}
</script>
