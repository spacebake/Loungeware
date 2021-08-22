<template>
  <div class="container full-width">
    <!-- Breadcrumbs -->
    <div class="row center-xs full-width">
      <div class="col-xs-12">
        <h2>
          <larold-img name="ghost larold" class="mr-1" />
          <router-link :to="{ name: 'browse' }"> All Games </router-link>
          /

          <router-link active-class="" :to="browseByAuthorRoute">
            {{ authorName }}
          </router-link>
          /

          {{ displayName }}
        </h2>
      </div>
    </div>

    <!-- BANNER -->
    <div class="row center-xs full-width">
      <div class="col">
        <!-- CART -->
        <img class="cart img-pixel media-border" :src="cartLabelSrc" />

        <!-- ACTIONS -->
        <div class="text-center mt-1">
          <a class="btn solid red mr-2">Play in gallery</a>
          <router-link :to="browseByAuthorRoute" v-if="!!microgame" class="btn">
            More from {{ authorName }}
          </router-link>
        </div>
      </div>
      <div class="col">
        <!-- INFO -->
        <div>
          <div class="title mt-1">INFO</div>
          <div class="">Added On {{ dateAdded }}</div>
          <div class="">Duration {{ gameDuration }} seconds</div>
        </div>
        <!-- CREDITS -->
        <div>
          <div v-if="credits.length > 0">
            <div class="title mt-2">CREDITS</div>
            <ul>
              <li v-for="(item, i) in credits" :key="i">
                {{ item }}
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <!-- No Game -->
    <div v-if="!game">
      <p>No game found</p>
    </div>

    <!-- LOADING -->
    <!-- <div v-else-if="$apollo.queries.microgame.loading">
      <p>Loading</p>
    </div> -->

    <div class="text-center">
      <h2 class="title">"{{ game.config.prompt }}"</h2>
    </div>

    <!-- IMAGES -->
    <div v-if="imageCount > 0" class="row center-xs full-width">
      <div class="col-xs-3" v-for="i in imageCount" :key="`${i}-image`">
        <img class="preview-img" :src="getImagePath(i)" />
      </div>
    </div>

    <!-- DESCRIPTION -->
    <div v-if="game.config.description" class="row center-xs full-width">
      <div class="col-xs-12">
        <div class="title">Description</div>
        <p
          v-for="(paragraph, i) in game.config.description"
          :key="`${i}-description`"
        >
          {{ paragraph }}
        </p>
      </div>
    </div>

    <!-- HOW TO PLAY -->
    <div v-if="game.config.how_to_play" class="row center-xs full-width">
      <div class="col-xs-12">
        <div class="title">How To Play</div>
        <p
          v-for="(paragraph, i) in game.config.how_to_play"
          :key="`${i}-how-to-play`"
        >
          {{ paragraph }}
        </p>
      </div>
    </div>

    <div class="border mt-2 mb-2" />

    <!-- Community -->
    <div class="row center-xs full-width">
      <div class="col-xs-12">
        <h2>
          <larold-img name="bunny larold" class="mr-1" />
          Community
        </h2>
      </div>
    </div>

    <!-- No Community -->
    <div class="text-center" v-if="!microgame">
      <p class="title">Community is disabled for this game</p>
    </div>

    <div v-else class="row center-xs full-width">
      <!-- RATING -->
      <div class="col">
        <div class="title">
          Rating
          <small> ( {{ ratingsCount }} )</small>
        </div>
        <div v-if="!!microgame">
          <div class="mb-1 mt-1">
            <strong
              >Difficulty:
              <span class="ml-1">{{ difficultyRating }}/5</span></strong
            >
          </div>
          <div>
            <strong>
              Favorited:
              <span class="ml-1">{{ timesFavorited }}</span>
            </strong>
          </div>
        </div>
      </div>

      <!-- Comments -->
      <div class="col">
        <div class="title">Comments</div>
        <div class="comment-box-container">
          <div v-if="microgame.ratings.length == 0">
            <p>No one has rated this game yet</p>
          </div>
          <div
            class="comment-box mt-1"
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

    <div v-if="!!microgame" class="border mt-2 mb-2" />
    <div v-if="!!microgame" class="row center-xs full-width">
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
</template>

<script lang="ts">
import LaroldImg from '@/components/LaroldImg.vue';
import RatingForm from './components/RatingForm.vue';
import { Component, Vue } from 'vue-property-decorator';
import * as common from '@/common/gamesList';
import * as schema from '@/gql/schema';
import gql from 'graphql-tag';
import { routeName } from '@/router';

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
          gameSlug: `${this.game.author_slug}-${this.game.game_slug}`,
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
            authorSlug
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
  private imageCount = 0;
  private mounted() {
    var http = new XMLHttpRequest();

    this.imageCount = 0;
    while (this.imageCount < 10) {
      http.open(
        'HEAD',
        '/screenshots/' +
          this.game?.name +
          '/image' +
          (this.imageCount + 1) +
          '.png',
        false
      );
      http.send();

      if (http.status == 404) {
        break;
      }
      this.imageCount++;
    }

    return http.status != 404;
  }

  private get game() {
    return common.games.find(
      (i) =>
        i.game_slug == this.$route.params.game &&
        i.author_slug == this.$route.params.author
    );
  }

  private get browseByAuthorRoute() {
    return {
      name: routeName('browse-by-author'),
      params: {
        author: this.authorSlug,
      },
    };
  }

  private getImagePath(index: number) {
    return `/screenshots/${this.game?.name}/image${index}.png`;
  }

  private get authorSlug() {
    return this.game?.author_slug || '';
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
    const dateAdded = this.game?.config?.date_added || '';

    if (typeof dateAdded === 'string') {
      return dateAdded;
    }
    if (typeof dateAdded === 'object') {
      try {
        return `${dateAdded.month}, ${dateAdded.day} ${dateAdded.year}`;
      } catch (err) {
        return '';
      }
    }
    return dateAdded;
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
    // if (credits.length == 0) {
    credits.unshift(this.authorName);
    // }
    return credits;
  }

  private onRatingSubmitSuccess() {
    this.$apollo.queries.microgame.refetch();
  }
}
</script>

<style lang="scss" scoped>
.cart {
  width: 608px;
  height: 288px;
}

.preview-img {
  width: 100%;
  height: auto;
}
</style>
