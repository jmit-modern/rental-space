export default function ({ $auth, store, redirect }) {
  if (!store.getters.isSpaceOwner) {
    return redirect('/mypage')
  }
}
