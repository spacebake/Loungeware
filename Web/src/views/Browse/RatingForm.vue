<template>
  <div v-if="microgameId" class="media-border rating-form mt-1">
    <div class="input-group">
      <div class="label">
        Favorite?
        <small>Tell us if this is one of your favorites</small>
      </div>
      <select v-model="inputs.isFavorited">
        <option>Yes</option>
        <option>No</option>
      </select>
    </div>
    <div class="input-group">
      <div class="label">
        Difficulty Rating
        <small>Tell us how difficult you found the game</small>
      </div>
      <select v-model="inputs.difficulty">
        <option>1</option>
        <option>2</option>
        <option>3</option>
        <option>4</option>
        <option>5</option>
      </select>
    </div>
    <div class="input-group">
      <div class="label">
        Leave a comment
        <small>Say whatever you want. Be nice to creators</small>
      </div>
      <textarea v-model="inputs.comment" />
    </div>

    <div class="text-center" v-if="!isSubmitting">
      <a @click="submit" class="btn solid mb-2 mt-2"> Submit Rating </a>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue, Emit } from 'vue-property-decorator';
import * as common from '@/common/gamesList';
import * as schema from '@/gql/schema';
import gql from 'graphql-tag';

@Component
export default class RatingForm extends Vue {
  @Prop(String) microgameId!: string;
  private isSubmitting = false;
  private inputs = {
    isFavorited: 'Yes',
    difficulty: '1',
    comment: '',
  };

  @Emit('success')
  private emitSubmitSuccess() {
    return;
  }

  private async submit() {
    if (this.isSubmitting) {
      return;
    }
    this.isSubmitting = true;
    try {
      const input: schema.AddMicrogameRatingInput = {
        microgameId: this.microgameId,
        comment: this.inputs.comment,
        difficulty: parseInt(this.inputs.difficulty),
        isFavorited: this.inputs.isFavorited === 'Yes',
      };
      const result = await this.$apollo.mutate<schema.Mutation>({
        variables: {
          input,
        },
        mutation: gql`
          mutation RatingForm_addMicrogameRating(
            $input: AddMicrogameRatingInput!
          ) {
            addMicrogameRating(input: $input) {
              id
              comment
              createdAt
              difficulty
              editedAt
              isFavorited
            }
          }
        `,
      });

      if (result.errors?.length) {
        throw result.errors[0];
      }
      this.emitSubmitSuccess();
    } catch (err) {
      alert(`${err?.message} || ${err}`);
    }

    this.isSubmitting = false;
  }
}
</script>

<style lang="scss" scoped>
.rating-form {
  padding: 20px;

  a {
    width: 200px;
  }
}
</style>
