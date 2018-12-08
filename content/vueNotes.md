---
title: "VueNotes"
date: 2017-11-08T20:40:52-05:00
draft: false
---

# VueJS Notes

Vue.js notes.

## Getting Started

Official Guides :

- [Vue-cli](https://github.com/vuejs/vue-cli) - <https://github.com/vuejs/vue-cli>
- [Vue.js](https://vuejs.org/v2/guide/) - <https://vuejs.org/>
- [Vuex](https://vuex.vuejs.org/) - <https://vuex.vuejs.org/>
- [Vue-router](https://router.vuejs.org/) - <https://router.vuejs.org/>

### Vue-cli

```
$ npm install --global vue-cli

$ vue init webpack my-project

$ cd my-project
$ npm install
$ npm run dev
```

### Vue.js

Follow the official guide.

```
new Vue({
  el: '#app',

  store,
  router,
  i18n,

  template: '<App/>',
  components: {
    App
  }
})
```

#### Component

```
{
  name: 'app',

  data() {
    return {}
  },

  computed: {},
  watch: {},

  props: {},

  methods: {},

  mixins: [],
  components: {},

  render(h) {
    return h()
  },

  directives: {},

  filters: {},

  // lifecycle hooks
}
```

```
* Computed vs Methods : A Computed will only re-evaluate when its dependencies have changed. A Method invocation will always run the function whenever a re-redner happens.

* Watch : can perform an asynchronous operation
```

#### Lifecycle Diagram

![Vue.js Lifecycle Diagram](https://vuejs.org/images/lifecycle.png)

#### Keywords

```
v-model :
v-bind (:) :
v-on (@) :

v-for :

v-if, v-else-if, v-else
v-show
v-once

ref
```

```
The parent-child component relationship : props down, events up.

* Prop Validation
* Custom Events
  * v-on:customEvent
  * this.$emit('customEvent')

'two-way binding' .sync (syntax sugar)
  * :foo.sync='oldVal' (:foo='oldVal' @update:foo='val => bar = val')
  * this.$emit('update:foo', newVal)
```

#### Transitions & Animation

1. v-enter
2. v-enter-active
3. v-enter-to
4. v-leave
5. v-leave-active
6. v-leave-to

(v- will be replaced by the name)

![Vue.js Transition](https://vuejs.org/images/transition.png)

```
<transition name="fade"></transition>
<transition-group></transition-group>

.fade-enter-active, .fade-leave-active {
  transition: opacity .5s
}
.fade-enter, .fade-leave-to {
  opacity: 0
}
```

#### Reusability & Composition

##### Mixins

A mixin object can contain any component options.

```
var mixin = {}
Vue.mixin({})
```

##### Custom Directives

Directive Hooks

1. bind
2. inserted
3. update
4. componentUpdated
5. unbind

Directive Hook Arguments

1. el
2. binding
3. vnode
4. oldVnode

```
directives: {}
Vue.directive('customDirective', {})
```

[Vue.js Custom Directives](https://vuejs.org/v2/guide/custom-directive.html)

##### Plugins

```
MyPlugin.install = (Vue, options) => {}
Vue.use(MyPlugin)
```

[Vue.js Plugins](https://vuejs.org/v2/guide/plugins.html)

#### Reactivity in Depth

Vue.js uses Object.defineProperty to convert data to getter/setters.

```
Vue.set(vm.vueObject, 'newObj', 2)
this.$set(this.vueObject, 'newObj', 2)
this.vueObject = Object.assign({}, this.vueObject, {a: 1, b: 2})
```

```
Async Update Queue the component will not re-render immediately unitl the next “tick”, when the queue is flushed.

Vue.nextTick(() => {})
this.$nextTick(() => {})
```

### Vuex

A single source of truth.

```
const store = new Vuex.Store({
  state: {
    count: 0
  },

  mutations: {
    increment(state, payload) {
      state.count += payload.amount
    }
  },

  actions: {
    increment({dispatch, commit, state, getters}, payload) {
      commit('increment', payload)
    }
  },

  getters: {
    count: (state, getters) => {
      return state.count
    }
  },

  modules: {
    a: moduleA,
    b: moduleB
  },

  plugins: [plugin]
})
```

```
Vuex - State
* initial state with all desired fields upfront

Vuex - Actions
* Actions handle arbitrary asynchronous operations
* Actions receive a context (same to store)
* Actions 1st parameters {commit, dispatch, state, getters} (from context)
* Actions 2nd parameters could be payload

Vuex - Mutations
* The exclusive way to change Vues State
* Mutations 1st parameters is 'state'
* Mutations 2nd parameters could be payload (an object)
* store.commit('')

Vuex - Getters
* Vuex store's computed properties
* Getters 1st parameters is 'state'
* Getters 2nd parameters could be other Getters
* store.getters.xxx
```

```
                      dispatch                Commit
                  ->->->->->->->->Actions->->->->->->->->
mapState        |                 (async)                 |
mapGetters      Vue                                   Mutations (sync)
mapMutations    |                                         |
mapActions        <-<-<-<-<-<-<-<-State<-<-<-<-<-<-<-<-<-
                                              Mutate
```

![Vuex](https://vuex.vuejs.org/en/images/vuex.png)

### Vue-router

```
/* Lazy Loading Routes */
consot cUser = () => import('./cUser.vue')

const router = new VueRouter({
    // history, hash, abstract
    mode: 'history',

    base: __dirname,
    routes: [
      {
        path: '/a',
        redirect: '/b'
      }, {
        path: '/',
        components: {
          default: cD,
          a: cA,
          b: cB
        }
      }, {
        path: '/user/:id',
        name: 'user',
        component: cUser,
        children: [{
          path: '',
          component: cUserHome
        }, {
          path: 'profile',
          component: cUserProfile,
        }]
      }, {
        path: '/post'
        component: cPost,
        beforeEnter: (to, from, next) => {}
      }
    ],

    scrollBehavior (to, from, savedPosition) {
      return new Promise((resolve, reject) => {
        setTimeout(() => {
          resolve({x: 0, y: 0})
        }, 500)
      })
    }
})

router.beforeEach((to, from, next) => {})
router.afterEach((to, from) => {})

router.push()
router.replace()
router.go()
```

```
beforeRouteEnter (to, from, next) {
  next(vm => {})
}
beforeRouteUpdate
beforeRouteLeave (to, from, next) {
  next()
}

```

```
<div>
  <router-link to="user/1"></router-link>
  <router-link to="user/1/profile"></router-link>
  <router-link :to="{name: 'user', params: {userId: 1}}"></router-link>
  <transition>
    <router-view></router-view>
  </transition>
  <router-view name="a"></router-view>
  <router-view name="b"></router-view>
</div>

this.$route.params
this.$route.query
this.$route.hash
```
