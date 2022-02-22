<template>
  <div class="pt-20">
    <section class="search max-w-7xl mx-auto">
      <div class="sm:hidden">
        <label for="tabs" class="sr-only">Select a tab</label>
        <select
          id="tabs"
          name="tabs"
          class="
            block
            w-full
            pl-3
            pr-10
            py-2
            text-base
            border-gray-300
            focus:outline-none focus:ring-indigo-500 focus:border-indigo-500
            sm:text-sm
            rounded-md
          "
        >
          <option v-for="tab in tabs" :key="tab" :selected="activeTab">
            {{ tab }}
          </option>
        </select>
      </div>
      <div class="hidden sm:block mb-4">
        <div class="border-b border-gray-200">
          <nav class="-mb-px flex space-x-8" aria-label="Tabs">
            <div
              v-for="tab in tabs"
              :key="tab"
              :class="[
                {
                  'hover:border-orange border-orange text-orange':
                    activeTab === tab,
                },
                'capitalize border-transparent hover:border-gray-500 whitespace-nowrap py-2 px-1 border-b-2 font-medium cursor-default',
              ]"
              @click="handleTabClick(tab)"
            >
              {{ $t(`top.searchTabs.${tab}`) }}
            </div>
          </nav>
        </div>
      </div>

      <!-- 日時から探す -->
      <DateSearch @search="handleSearch" />
      <!-- End: 日時から探す -->

      <!-- 目的から探す -->
      <SpaceCategoryList :tab="activeTab" />
      <!-- End: 目的から探す -->

      <!-- キーワードで探す -->
      <KeywordSearch @search="handleSearchKeyword" />
      <!--End: キーワードで探す -->

      <!-- 人気の場所から探す -->
      <PopularArea />
      <!--End: 人気の場所から探す -->
    </section>

    <!-- 新着レンタルスペース -->
    <section class="new-space mt-20 max-w-7xl mx-auto">
      <NewSpaces />
    </section>
    <!-- End: 新着レンタルスペース -->

    <section class="mt-20 max-w-7xl mx-auto">
      <EventList />
    </section>

    <!-- ピックアップスペース -->
    <section class="pickup-space mt-20 max-w-7xl mx-auto">
      <PickupSpaces />
    </section>
    <!-- End: ピックアップスペース -->

    <!-- Rent Guid -->
    <section class="mt-20">
      <RentGuide />
    </section>
    <!-- End: Rent Guid -->

    <section class="max-w-7xl mx-auto lg:mt-40">
      <!-- 目的から探す -->
      <SpaceCategoryList />
      <!-- End: 目的から探す -->
      <LocationList />
    </section>
  </div>
</template>

<script>
import DateSearch from '@/components/organisms/page/top/DateSearch'
import KeywordSearch from '@/components/organisms/page/top/KeywordSearch'
import SpaceCategoryList from '@/components/organisms/page/top/SpaceCategoryList'
import PopularArea from '@/components/organisms/page/top/PopularArea'
import NewSpaces from '@/components/organisms/page/top/NewSpaces'
import EventList from '@/components/organisms/page/top/EventList'
import PickupSpaces from '@/components/organisms/page/top/PickupSpaces'
import LocationList from '@/components/organisms/page/top/LocationList'
import RentGuide from '@/components/organisms/page/top/RentGuide'
import { filterQueryParams } from '@/utils/http'

export default {
  components: {
    DateSearch,
    KeywordSearch,
    PopularArea,
    NewSpaces,
    PickupSpaces,
    RentGuide,
    LocationList,
    EventList,
    SpaceCategoryList,
  },
  data() {
    return {
      inputs: {
        pickDate: null,
        startTime: null,
        endTime: null,
        prefecture: null,
        keyword: null,
      },
      tabs: ['space', 'expert', 'event'],
      activeTab: 'space',
    }
  },
  methods: {
    handleTabClick(tabName) {
      this.activeTab = tabName
    },
    handleSearch(inputs) {
      const params = {
        starting_at: inputs.pickDate
          ? this.$dayjs(inputs.pickDate)
              .hour(inputs.startTime)
              .format('YYYY-MM-DD H:mm:ss')
          : null,
        ending_at: inputs.pickDate
          ? this.$dayjs(inputs.pickDate)
              .hour(inputs.endTime ? inputs.endTime : 23)
              .format('YYYY-MM-DD H:mm:ss')
          : null,
        prefecture: inputs.prefecture,
      }
      const query = filterQueryParams(params)

      const targetUrl = this.localePath(this.activeTab)
      this.$router.push({ path: targetUrl, query })
    },
    handleSearchKeyword(inputs) {
      const query = filterQueryParams(inputs)

      const targetUrl = this.localePath(this.activeTab)
      this.$router.push({ path: targetUrl, query })
    },
  },
}
</script>
