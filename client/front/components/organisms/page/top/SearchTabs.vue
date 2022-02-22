<template>
  <div>
    <TabCard :tabs="tabs" :initial-tab="initialTab">
      <template slot="tab-head-space">
        <div class="flex items-center">
          <outline-office-building-icon class="w-5 h-5" />
          <span class="ml-1">Space</span>
        </div>
      </template>
      <template slot="tab-panel-space">
        <!-- 日時から探す -->
        <DateSearch />
        <!-- End: 日時から探す -->

        <!-- 目的から探す -->
        <SpaceCategoryList />
        <!-- End: 目的から探す -->

        <!-- キーワードで探す -->
        <KeywordSearch />
        <!--End: キーワードで探す -->
      </template>

      <template slot="tab-head-event">
        <div class="flex items-center">
          <outline-calendar-icon class="w-5 h-5" />
          <span class="ml-1">Event</span>
        </div>
      </template>
      <template slot="tab-panel-event"> </template>

      <template slot="tab-head-expert">
        <div class="flex items-center">
          <outline-user-icon class="w-5 h-5" />
          <span class="ml-1">Expert</span>
        </div>
      </template>
      <template slot="tab-panel-expert"> </template>
    </TabCard>
  </div>
</template>

<script>
import TabCard from '@/components/molecules/TabCard'
import DateSearch from '@/components/organisms/page/top/DateSearch'
import SpaceCategoryList from '@/components/organisms/page/top/SpaceCategoryList'
import KeywordSearch from '@/components/organisms/page/top/KeywordSearch'

export default {
  components: {
    TabCard,
    DateSearch,
    SpaceCategoryList,
    KeywordSearch,
  },
  data() {
    return {
      initialTab: 'space',
      tabs: ['space', 'event', 'expert'],
    }
  },
}
</script>
