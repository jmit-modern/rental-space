<template>
  <div>
    <div class="pt-20 text-center text-3xl font-bold mb-20 text-primary">
      {{ $t('top.rentGuide.title') }}
    </div>

    <!-- Testimonial section -->
    <div
      class="
        pb-16
        bg-gradient-to-r
        from-orange
        to-tertiary
        lg:pb-0 lg:z-10 lg:relative
      "
    >
      <div
        class="lg:mx-auto lg:max-w-7xl lg:px-8 lg:grid lg:grid-cols-3 lg:gap-12"
      >
        <div class="relative lg:-my-12">
          <div
            aria-hidden="true"
            class="absolute inset-x-0 top-0 h-1/2 bg-white lg:hidden"
          />
          <div
            class="mx-auto max-w-md px-4 sm:max-w-3xl sm:px-6 lg:p-0 lg:h-full"
          >
            <div class="rounded-xl bg-white step-inner">
              <div
                class="
                  rounded-t-xl
                  aspect-w-10 aspect-h-6
                  overflow-hidden
                  sm:aspect-w-16 sm:aspect-h-7
                  lg:aspect-none lg:h-64
                "
              >
                <img
                  class="object-cover lg:w-full lg:h-full"
                  src="~/assets/image/reserve-step1.jpg"
                  alt=""
                />
              </div>
              <div class="text-center text-xl font-bold py-6">
                スペースを探す
              </div>
              <div class="px-8 pb-10 pt-0 text-sm">
                お客様の条件、好みにあわせてレンタルできるスペースを見つけてください。
              </div>
            </div>
          </div>
        </div>
        <div class="relative lg:-my-12">
          <div
            aria-hidden="true"
            class="absolute inset-x-0 top-0 h-1/2 bg-white lg:hidden"
          />
          <div
            class="mx-auto max-w-md px-4 sm:max-w-3xl sm:px-6 lg:p-0 lg:h-full"
          >
            <div class="rounded-xl bg-white step-inner">
              <div
                class="
                  rounded-t-xl
                  aspect-w-10 aspect-h-6
                  overflow-hidden
                  sm:aspect-w-16 sm:aspect-h-7
                  lg:aspect-none lg:h-64
                "
              >
                <img
                  class="object-cover lg:w-full lg:h-full"
                  src="~/assets/image/reserve-step2.jpg"
                  alt=""
                />
              </div>
              <div class="text-center text-xl font-bold py-6">
                スペースを予約
              </div>
              <div class="px-8 pb-10 pt-0 text-sm">
                お部屋の条件等を確認し、日時を指定してスペースを予約！
              </div>
            </div>
          </div>
        </div>
        <div class="relative lg:-my-12">
          <div
            aria-hidden="true"
            class="absolute inset-x-0 top-0 h-1/2 bg-white lg:hidden"
          />
          <div
            class="mx-auto max-w-md px-4 sm:max-w-3xl sm:px-6 lg:p-0 lg:h-full"
          >
            <div class="rounded-xl bg-white step-inner">
              <div
                class="
                  rounded-t-xl
                  aspect-w-10 aspect-h-6
                  overflow-hidden
                  sm:aspect-w-16 sm:aspect-h-7
                  lg:aspect-none lg:h-64
                "
              >
                <img
                  class="object-cover lg:w-full lg:h-full"
                  src="~/assets/image/reserve-step3.jpg"
                  alt=""
                />
              </div>
              <div class="text-center text-xl font-bold py-6">
                スペースを利用する
              </div>
              <div class="px-8 pb-10 pt-0 text-sm">
                あとは指定した日時に現地へ行って利用するだけ！
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {}
</script>

<style lang="scss" scoped>
.step-inner {
  box-shadow: 0 0 10px rgb(0 0 0 / 20%);
}
</style>
