<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />

    <mypage-layout>
      <div class="px-4 py-5">
        <div class="mb-8">
          <div class="text-xl">スペース詳細</div>
        </div>
        <SpaceForm :data="inputs" form-type="create" />
      </div>
    </mypage-layout>
  </div>
</template>

<script>
import Breadcrumb from '@/components/organisms/Breadcrumb'
import MypageLayout from '@/components/organisms/templates/mypage/Layout'
import SpaceForm from '@/components/organisms/templates/mypage/myspace/Form'

export default {
  components: {
    Breadcrumb,
    MypageLayout,
    SpaceForm,
  },
  data() {
    return {
      inputs: {
        spaceImages: [],
        cancellationDeadline: 48,
        status: 0,
      },
    }
  },
  computed: {
    breadcrumbs() {
      return [
        {
          id: 1,
          name: 'ホーム',
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: 'マイページ',
          url: this.localeRoute({ name: 'mypage' }),
        },
        {
          id: 3,
          name: 'マイスペース',
          url: this.localeRoute({ name: 'mypage-myspace' }),
        },
        {
          id: 4,
          name: '新規登録',
        },
      ]
    },
  },
}
</script>
