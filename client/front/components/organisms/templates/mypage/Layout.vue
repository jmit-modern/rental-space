<template>
  <div>
    <div class="py-10">
      <div class="mx-auto lg:grid lg:grid-cols-12 lg:gap-8">
        <div class="hidden lg:block lg:col-span-3 xl:col-span-2">
          <SideNav />
        </div>
        <div class="lg:col-span-9 xl:col-span-9">
          <slot></slot>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import SideNav from '@/components/organisms/templates/mypage/SideNav'
export default {
  components: { SideNav },
}
</script>
