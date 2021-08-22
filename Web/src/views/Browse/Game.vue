<template>
  <div class="container full-width">
    <div class="row center-xs full-width">
      <div class="col-xs-12">
        <h2>
          <larold-img name="ghost larold" class="mr-1" />
          <router-link :to="{ name: 'browse' }"> All Games </router-link>
          /
          {{ displayName }}
        </h2>
        <div v-if="microgame">
          <div class="btn solid red">About</div>
          <div class="btn">Play</div>
          <div class="btn">More from {{ authorName }}</div>
        </div>
      </div>
    </div>
    <div v-if="$apollo.queries.microgame.loading"></div>
    <div v-else-if="!microgame">
      <img class="cart img-pixel media-border" :src="cartLabelSrc" />
      <p>
        This game has not been claimed yet. <a href="#">Is this your game?</a>
      </p>
    </div>
    <div v-else>
      <div class="row center-xs full-width">
        <div class="col-xs-12 col-md-6">
          <div v-if="!game">Could not find game</div>
          <div v-else>
            <img class="cart img-pixel media-border" :src="cartLabelSrc" />

            <div class="title mt-1">INFO</div>
            <div>
              <strong>{{ displayName }}</strong> by
              <strong>{{ authorName }}</strong> On
              <strong>{{ dateAdded }}</strong>
            </div>
            <div>Duration {{ gameDuration }} seconds</div>

            <div class="title mt-1">
              Community Rating <small> ( {{ ratingsCount }} )</small>
            </div>
            <div>
              Difficulty: <span class="ml-1">{{ difficultyRating }}/5</span>
            </div>
            <div>
              Favorited: <span class="ml-1">{{ timesFavorited }}</span>
            </div>

            <div v-if="credits.length > 0">
              <div class="title mt-2">CREDITS</div>
              <div>Featuring</div>
              <ul>
                <li v-for="(item, i) in credits" :key="i">
                  {{ item }}
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-xs-12 col-md-6">
          <div class="media-border" style="width: 100%; height: 340px">
            <!-- run html5 but with only one game loaded? <br />
            preview images? -->
          </div>
        </div>
      </div>
      <div v-if="hasRatings" class="border mt-2 mb-2" />
      <div v-if="hasRatings" class="row center-xs full-width">
        <div class="col-xs-12">
          <h2>
            <larold-img name="bunny larold" class="mr-1" />
            Comments
          </h2>

          <div v-if="microgame.ratings.length == 0">
            <p>No one has rated this game before</p>
          </div>
          <div class="comment-box-container" v-else>
            <div
              class="comment-box"
              v-for="(rating, i) in microgame.ratings"
              :key="`${i}-rating`"
              v-show="!!rating.comment"
            >
              <span class="title">
                {{ rating.author.displayName }}
              </span>
              <span v-if="rating.createdAt != rating.editedAt">
                edited on
                <strong>
                  {{ rating.editedAt | moment('dddd, MMMM Do YYYY') }}
                </strong>
              </span>
              <span v-else>
                on
                <strong>
                  {{ rating.createdAt | moment('dddd, MMMM Do YYYY') }}
                </strong>
              </span>

              <p>
                {{ rating.comment }}
              </p>
            </div>
          </div>
        </div>
      </div>
      <div class="border mt-2 mb-2" />
      <div class="row center-xs full-width">
        <div class="col-xs-12">
          <h2>
            <larold-img name="frog larold" class="mr-1" />
            <span v-if="hasMyRating"> Update your rating! </span>
            <span v-else> Rate This Game! </span>
          </h2>

          <p v-if="!hasRatings">
            This game has no ratings, help it out by being the first!
          </p>

          <div v-if="!$auth.isInitialized">Loading</div>
          <div v-else-if="!$auth.isLoggedIn">
            <p>You must be logged in to rate games</p>
          </div>
          <div v-else-if="!microgame">
            <p>What happened to the microgame?</p>
          </div>
          <rating-form
            @success="onRatingSubmitSuccess"
            v-else
            :microgameId="microgame.id"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import LaroldImg from '@/components/LaroldImg.vue';
import RatingForm from './RatingForm.vue';
import { Component, Vue } from 'vue-property-decorator';
// import { RouteName, getLinkPath } from '@/router';
import * as common from '@/common/gamesList';
import * as schema from '@/gql/schema';
import gql from 'graphql-tag';
import auth from '@/plugins/auth';

@Component({
  components: {
    LaroldImg,
    RatingForm,
  },
  apollo: {
    microgame: {
      fetchPolicy: 'cache-and-network',
      variables() {
        return {
          gameSlug: this.game.name.replaceAll('_', '-'),
        };
      },
      query: gql`
        query Game_microgame($gameSlug: String!) {
          microgame(gameSlug: $gameSlug) {
            id
            author {
              id
              displayName
            }
            hasMyRating
            ratings {
              id
              comment
              difficulty
              editedAt
              createdAt
              isFavorited
              author {
                id
                displayName
              }
            }
          }
        }
      `,
    },
  },
})
export default class Game extends Vue {
  private microgame!: schema.Microgame;

  private get game() {
    return common.games.find(
      (i) => i.name.replaceAll('_', '-') == this.$route.params.gameSlug
    );
  }

  private get cartLabelSrc() {
    return this.game ? `/games/${this.game.name}.png` : '';
  }

  private get displayName() {
    return this.game?.config?.game_name || '';
  }

  private get authorName() {
    return this.game?.config?.creator_name || '';
  }

  private get dateAdded() {
    return this.game?.config?.date_added || '';
  }

  private get gameDuration() {
    return this.game?.config?.time_seconds || 0;
  }

  private get hasMyRating() {
    return this.microgame?.hasMyRating || false;
  }

  private get hasRatings() {
    return this.microgame?.ratings?.length > 0 || false;
  }

  private get timesFavorited() {
    let val = 0;
    this.microgame?.ratings?.forEach((i) => {
      val += i.isFavorited ? 1 : 0;
    });
    return val;
  }

  private get difficultyRating() {
    let val = 0;
    this.microgame?.ratings?.forEach((i) => {
      val += i.difficulty;
    });
    val /= this.microgame?.ratings?.length || 1;
    return val;
  }

  private get ratingsCount() {
    return this.microgame?.ratings?.length || 0;
  }

  private get credits() {
    const credits = this.game?.config.credits || [];
    const index = credits.findIndex((i) => i == this.authorName);
    if (index >= 0) {
      credits.splice(index, 1);
    }
    if (credits.length > 0) {
      credits.unshift(this.authorName);
    }
    return credits;
  }

  private onRatingSubmitSuccess() {
    this.$apollo.queries.microgame.refetch();
  }
}
</script>

<style lang="scss" scoped>
.cart {
  width: 300px;
  height: 155px;
}

.rating-form {
  padding: 20px;
}
</style>
