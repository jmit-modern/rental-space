<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Breadcrumb :items="breadcrumbs" />
    </div>
    <div class="mt-16">
      <div class="text-center text-lg px-4">
        The user registration is done. We have sent you the verification email.
        <br />
        Please follow the instruction in the email to complete the registration.
      </div>
    </div>
  </div>
</template>

<script>
import Breadcrumb from '@/components/organisms/Breadcrumb'
export default {
  components: {
    Breadcrumb,
  },
  computed: {
    breadcrumbs() {
      return [
        {
          id: 1,
          name: 'ホーム',
          url: { name: 'index___jp', query: {} },
        },
        {
          id: 2,
          name: '登録完了',
          url: null,
        },
      ]
    },
  },
}
</script>
