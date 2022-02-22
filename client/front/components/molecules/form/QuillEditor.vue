<template>
  <div>
    <div
      ref="myQuillEditor"
      v-quill:myQuillEditor="editorOption"
      class="quill-editor"
      :content="value"
      @blur="onEditorBlur($event)"
      @focus="onEditorFocus($event)"
      @ready="onEditorReady($event)"
      @change="onEditorChange($event)"
    ></div>
  </div>
</template>

<script>
import Vue from 'vue'
export default {
  props: {
    value: {
      type: String,
      default: null,
    },
    placeholder: {
      type: String,
      default: null,
    },
  },
  data() {
    return {
      editorOption: {},
    }
  },
  beforeMount() {
    const VueQuillEditor = require('vue-quill-editor/dist/ssr')
    const Quill = require('quill')
    const { ImageExtend, QuillWatch } = require('quill-image-extend-module')

    const toolbarOptions = [
      ['bold', 'italic', 'underline', 'strike'], // toggled buttons

      [
        {
          header: 2,
        },
      ], // custom button values
      [
        {
          list: 'ordered',
        },
        {
          list: 'bullet',
        },
      ],

      [
        {
          size: ['small', false, 'large', 'huge'],
        },
      ], // custom dropdown

      [
        {
          color: [],
        },
        {
          background: [],
        },
      ], // dropdown with defaults from theme
      [
        {
          font: [],
        },
      ],
      [
        {
          align: [],
        },
      ],

      ['link', 'image', 'video'], // remove formatting button
    ]

    this.editorOption = {
      bounds: 'app',
      placeholder: this.placeholder,
      modules: {
        ImageExtend: {
          loading: true,
          name: 'image', // Name of the file received by the backend,
          size: 3, // Optional parameter Picture size in M, 1M = 1024kb.
          action: `${process.env.API_URL}/api/imageS3Upload`, // Backend receive file api
          response: (res) => {
            return res.data.url
          },
          headers: (xhr) => {}, // Set the header token
          sizeError: () => {}, // Picture oversize callback
          start: () => {}, // Optional parameter Custom start upload trigger event
          end: () => {}, // Optional parameters Customize the events triggered by the end of the upload, whether successful or failed.
          error: () => {}, // Optional parameters Events triggered by failed uploads
          success: () => {}, // Optional parameters Events triggered by successful uploads
          change: (xhr, formData) => {
            // xhr.setRequestHeader('myHeader','myValue')
            // formData.append('token', 'myToken')
          }, // Optional parameters triggered each time an image is selected, can also be used to set the header, but has one more parameter than headers to set formData.
        },
        toolbar: {
          handlers: {
            image() {
              QuillWatch.emit(this.quill.id)
            },
          },
          container: toolbarOptions,
        },
      },
    }
    Quill.register('modules/ImageExtend', ImageExtend)
    Vue.use(VueQuillEditor)
  },
  methods: {
    onEditorBlur(editor) {
      // console.log('editor blur!', editor)
    },
    onEditorFocus(editor) {
      console.log('editor focus!', editor)
    },
    onEditorReady(editor) {
      // console.log('editor ready!', editor)
    },
    onEditorChange({ editor, html, text }) {
      // console.log('editor change!', editor, html, text)
      this.$emit('input', html)
    },
  },
}
</script>

<style lang="scss" scoped>
.container {
  width: 60%;
  margin: 0 auto;
  padding: 50px 0;
  .quill-editor {
    min-height: 200px;
    max-height: 400px;
    overflow-y: auto;
  }
}
</style>
