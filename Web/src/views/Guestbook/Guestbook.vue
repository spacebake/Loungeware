<template>
  <div class="container full-width">
    <div class="row center-xs">
      <div class="col-xs-12">
        <h2><larold-img name="awesome larold" /> Sign Our Guestbook</h2>

        <div v-if="$apollo.loading && !guestbooks">Am loading</div>
        <div v-else-if="guestbooks.length == 0">
          I'm sorry but there's nothing here
        </div>
        <div class="guestbook" v-else>
          <div v-for="(entry, i) in guestbooks" :key="i">
            <div class="gb-entry media-border" v-if="entry.author">
              <div>
                <span class="title">{{ entry.author.displayName }}</span> on
                <strong>{{
                  entry.createdAt | moment('dddd, MMMM Do YYYY')
                }}</strong>
              </div>
              <div class="mt-1">{{ entry.text }}</div>
            </div>
          </div>
        </div>
        <div class="border mb-2 mt-2" />
        <div class="mt-2">
          <h3>
            <LaroldImg name="helicopter larold" />
            Sign Below
            <small class="ml-1">Warning, you only get one shot</small>
          </h3>
          <div v-if="!isAuthInitialized">
            <p>Loading</p>
          </div>
          <div v-else-if="!isLoggedIn">
            <p>You must be logged in to sign Larold's Guestbook</p>
          </div>
          <div style="display: flex; flex-direction: column" v-else>
            <textarea
              class="media-border"
              v-model="text"
              placeholder="Hello Larold"
            />
            <div class="text-center">
              <div class="btn solid mt-1" style="width: 200px" @click="submit">
                Submit
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import LaroldImg from '@/components/LaroldImg.vue';
import gql from 'graphql-tag';
import { Component, Vue } from 'vue-property-decorator';
import * as schema from '@/gql/schema';

@Component({
  components: {
    LaroldImg,
  },
  metaInfo: {
    title: 'Sign Our Guestbook',
  },
  apollo: {
    guestbooks: {
      query: gql`
        query Guestbook_guestbooks {
          guestbooks {
            id
            text
            createdAt
            author {
              id
              displayName
            }
          }
        }
      `,
    },
  },
})
export default class Guestbook extends Vue {
  private guestbooks?: schema.Guestbook[];
  private text = '';
  private isSubmitting = false;

  private get isAuthInitialized() {
    return this.$auth.isInitialized;
  }

  private get isLoggedIn() {
    return this.$auth.isLoggedIn;
  }

  private async submit() {
    if (this.isSubmitting) {
      return;
    }
    this.isSubmitting = true;
    try {
      if (!this.text) {
        throw new Error('Cannot submit empty message');
      }
      const input: schema.GuestbookCreateInput = {
        text: this.text,
      };
      const result = await this.$apollo.mutate<schema.Mutation>({
        variables: { input },
        mutation: gql`
          mutation Guestbook_submit($input: GuestbookCreateInput!) {
            guestbookCreate(input: $input) {
              id
            }
          }
        `,
      });

      if (result.errors && result.errors.length > 0) {
        throw result.errors[0];
      }

      await this.$apollo.queries.guestbooks.refetch();
    } catch (err) {
      alert(`${err?.message || err}`);
      await this.$apollo.queries.guestbooks.refetch();
    }
    this.isSubmitting = false;
  }
}
</script>

<style lang="scss" scoped>
::-webkit-scrollbar {
  width: 20px;
}

::-webkit-scrollbar-track {
  background: darken(#1a1721, 3);
}

::-webkit-scrollbar-thumb {
  background: lighten(#1a1721, 20);
}

::-webkit-scrollbar-thumb:hover {
  background: lighten(#1a1721, 30);
}
textarea {
  max-width: 100%;
  min-height: 100px;
  padding: 20px;
  background-color: rgba(0, 0, 0, 0.3);
  color: #fff;
}

.guestbook {
  max-height: 500px;
  overflow-y: scroll;
  overflow-x: hidden;
  padding-right: 50px;

  .gb-entry {
    width: 100%;
    padding: 20px;
    // margin-right: 100px;
    // border: solid thin #ddd;

    .title {
      font-size: 1.2rem;
      font-weight: bold;
    }
  }
}
</style>
