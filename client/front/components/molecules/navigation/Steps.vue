<!-- This example requires Tailwind CSS v2.0+ -->
<template>
  <nav aria-label="Progress">
    <ol
      role="list"
      class="
        border border-gray-300
        rounded-md
        divide-y divide-gray-300
        md:flex md:divide-y-0
      "
    >
      <li
        v-for="(step, stepIdx) in steps"
        :key="step.name"
        class="relative md:flex-1 md:flex"
      >
        <nuxt-link
          v-if="step.status === 'complete'"
          :to="step.route"
          class="group flex items-center w-full"
        >
          <span class="px-6 py-4 flex items-center text-sm font-medium">
            <span
              class="
                flex-shrink-0
                w-10
                h-10
                flex
                items-center
                justify-center
                bg-orange
                rounded-full
                group-hover:bg-opacity-80
              "
            >
              <outline-check-icon
                class="w-6 h-6 text-white"
                aria-hidden="true"
              />
            </span>
            <span class="ml-4 text-sm font-medium text-gray-900">{{
              step.name
            }}</span>
          </span>
        </nuxt-link>
        <nuxt-link
          v-else-if="step.status === 'current'"
          :to="step.route"
          class="px-6 py-4 flex items-center text-sm font-medium"
          aria-current="step"
        >
          <span
            class="
              flex-shrink-0
              w-10
              h-10
              flex
              items-center
              justify-center
              border-2 border-orange
              rounded-full
            "
          >
            <span class="text-orange">{{ step.id }}</span>
          </span>
          <span class="ml-4 text-sm font-medium text-orange">{{
            step.name
          }}</span>
        </nuxt-link>
        <nuxt-link v-else :to="step.route" class="group flex items-center">
          <span class="px-6 py-4 flex items-center text-sm font-medium">
            <span
              class="
                flex-shrink-0
                w-10
                h-10
                flex
                items-center
                justify-center
                border-2 border-gray-300
                rounded-full
                group-hover:border-gray-400
              "
            >
              <span class="text-gray-500 group-hover:text-gray-900">{{
                step.id
              }}</span>
            </span>
            <span
              class="
                ml-4
                text-sm
                font-medium
                text-gray-500
                group-hover:text-gray-900
              "
              >{{ step.name }}</span
            >
          </span>
        </nuxt-link>
        <template v-if="stepIdx !== steps.length - 1">
          <!-- Arrow separator for lg screens and up -->
          <div
            class="hidden md:block absolute top-0 right-0 h-full w-5"
            aria-hidden="true"
          >
            <svg
              class="h-full w-full text-gray-300"
              viewBox="0 0 22 80"
              fill="none"
              preserveAspectRatio="none"
            >
              <path
                d="M0 -2L20 40L0 82"
                vector-effect="non-scaling-stroke"
                stroke="currentcolor"
                stroke-linejoin="round"
              />
            </svg>
          </div>
        </template>
      </li>
    </ol>
  </nav>
</template>

<script>
export default {
  components: {},
  props: {
    steps: {
      type: Array,
      default: null,
    },
  },
}
</script>
