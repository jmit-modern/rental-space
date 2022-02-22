<template>
  <div class="space-y-5">
    <!-- Title -->
    <div class="text-2xl font-bold">
      {{ space.name }}
    </div>

    <!-- Quarantine -->
    <div class="flex">
      <div class="mr-2">
        <img src="@/assets/image/quarantine.svg" alt="" />
      </div>
      <div>
        <h3 class="font-bold text-lg">
          {{ $t('space.detail.counterInfection') }}
        </h3>
        <div>
          このスペースは利用された後、スタッフが毎回必ず清掃と除菌を行なっています。
        </div>
      </div>
    </div>
    <Divider />

    <!-- Space Description -->
    <div class="py-5">
      <h3 class="font-bold mb-3 text-lg">
        {{ $t('space.detail.description') }}
      </h3>
      <div v-html="space.description"></div>
    </div>

    <Divider />

    <!-- Facilities -->
    <div v-if="space.facility" class="py-5">
      <h3 class="font-bold mb-3 text-lg">{{ $t('space.detail.equipment') }}</h3>
      <div v-html="space.facility"></div>
    </div>
    <Divider />

    <!-- Lodging -->
    <div v-if="space.lodging" class="py-5">
      <h3 class="font-bold mb-3 text-lg">{{ $t('space.detail.lodging') }}</h3>
      <div v-html="space.lodging"></div>
    </div>
    <Divider />

    <!-- Loud volume -->
    <div v-if="space.loudVolume" class="py-5">
      <h3 class="font-bold mb-3 text-lg">
        {{ $t('space.detail.loudVolume') }}
      </h3>
      <div v-html="space.loudVolume"></div>
    </div>
    <Divider />

    <!-- Cooking -->
    <div v-if="space.cooking" class="py-5">
      <h3 class="font-bold mb-3 text-lg">{{ $t('space.detail.cooking') }}</h3>
      <div v-html="space.cooking"></div>
    </div>
    <Divider />

    <!-- Wi-Fi -->
    <div v-if="space.wifi" class="py-5">
      <h3 class="font-bold mb-3 text-lg">{{ $t('space.detail.wifi') }}</h3>
      <div v-html="space.wifi"></div>
    </div>
    <Divider />

    <!-- Parking -->
    <div v-if="space.parking" class="py-5">
      <h3 class="font-bold mb-3 text-lg">{{ $t('space.detail.parking') }}</h3>
      <div v-html="space.parking"></div>
    </div>
    <Divider />

    <!-- Access -->
    <div class="py-5">
      <h3 class="font-bold mb-3 text-lg">{{ $t('space.detail.access') }}</h3>
      <div class="mb-5">
        <GoogleMap v-if="locationObj" :location="locationObj" />
      </div>
      <div class="table mb-5">
        <div class="table-row">
          <div class="table-cell w-36 py-2 text-primary">
            {{ $t('space.detail.address') }}
          </div>
          <div class="">{{ space.address1 }}</div>
        </div>
        <div class="table-row">
          <div class="table-cell w-36 py-2 text-primary">
            {{ $t('space.detail.nearestStation') }}
          </div>
          <div v-html="space.address2"></div>
        </div>
        <div class="table-row">
          <div class="table-cell w-36 py-2 text-primary">
            {{ $t('space.detail.access') }}
          </div>
          <div v-html="space.address3"></div>
        </div>
      </div>
      <div class="text-right">
        <a
          :href="`http://maps.google.com/maps?q=${locationQuery}`"
          target="_blank"
          >{{ $t('space.detail.checkInGMap') }}</a
        >
      </div>
    </div>
    <Divider />

    <!-- Plan List -->
    <div class="py-5">
      <div class="text-2xl text-primary font-bold mb-6 mt-8">
        {{ $t('space.detail.planList') }}
      </div>
      <SpacePlan :items="space.spacePlans" />
    </div>

    <!-- Facilities -->
    <div class="py-5">
      <div class="text-2xl text-primary font-bold mb-6 mt-8">
        {{ $t('space.detail.facilities') }}
      </div>
      <SpaceFacility :items="space.facilities" />
    </div>

    <!-- Space Owner -->
    <div class="py-5">
      <div class="text-2xl text-primary font-bold mb-6 mt-8">
        {{ $t('space.detail.ownerSpace') }}
      </div>
      <SpaceHost :owner="space.owner" />
    </div>

    <!-- Related Spaces -->
    <div class="py-5">
      <div class="text-2xl text-primary font-bold mb-6 mt-8">
        {{ $t('space.detail.relatedSpaces') }}
      </div>
      <RelatedSpaces />
    </div>
  </div>
</template>

<script>
import Divider from '@/components/atoms/Divider'
import SpacePlan from '@/components/organisms/page/space/SpacePlan'
import SpaceHost from '@/components/organisms/page/space/SpaceHost'
import SpaceFacility from '@/components/organisms/page/space/SpaceFacility'
import RelatedSpaces from '@/components/organisms/page/space/RelatedSpaces'
import GoogleMap from '@/components/molecules/GoolgeMap'

export default {
  components: {
    Divider,
    SpacePlan,
    SpaceHost,
    SpaceFacility,
    RelatedSpaces,
    GoogleMap,
  },
  props: {
    space: {
      type: Object,
      default: null,
    },
  },
  computed: {
    locationQuery() {
      return this.space.lat && this.space.lng
        ? [this.space.lat, this.space.lng].join(',')
        : this.space.address1
    },
    locationObj() {
      return this.space.lat && this.space.lng
        ? {
            lat: parseInt(this.space.lat),
            lng: parseInt(this.space.lng),
          }
        : null
    },
  },
}
</script>
