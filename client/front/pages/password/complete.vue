<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Breadcrumb :items="breadcrumbs" />
    </div>
    <div class="mt-16">
      <div class="text-center text-lg px-4">
        We have sent you the password reset email. <br />
        Please reset your password from the link in the email.
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
          name: 'パスワード更新完了',
          url: null,
        },
      ]
    },
  },
}
</script>
