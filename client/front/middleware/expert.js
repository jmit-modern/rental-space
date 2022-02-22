export default function ({ $auth, store, redirect }) {
  if (!store.getters.isExpert) {
    return redirect('/mypage')
  }
}
